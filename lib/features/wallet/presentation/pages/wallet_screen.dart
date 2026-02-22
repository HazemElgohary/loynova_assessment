import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loynova_assessment/core/di/injection.dart';
import 'package:loynova_assessment/core/utils/responsive_layout.dart';
import 'package:loynova_assessment/features/wallet/presentation/widgets/loaders/trans_item_loader.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/utils/translations_keys.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../manager/wallet_bloc.dart';
import '../manager/wallet_event.dart';
import '../manager/wallet_states.dart';
import '../widgets/balance_card.dart';
import '../widgets/filter_chips.dart';
import '../widgets/transaction_item.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<WalletBloc>().add(const LoadWallet());
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          context.read<WalletBloc>().add(const LoadMoreTransactions());
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.tr(TranslationsKeys.wallet))),
      body: BlocBuilder<WalletBloc, WalletState>(
        builder: (context, state) {
          if (state is WalletLoading) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey,
                    highlightColor: Colors.grey.shade100,
                    child: Card(
                      color: const Color(0xFF6C5CE7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const SizedBox(height: 150),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Shimmer.fromColors(
                    baseColor: Colors.grey,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      color: const Color(0xFF6C5CE7),
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(12),
                      // ),
                      child: const SizedBox(height: 50),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...List.generate(5, (index) => const TransItemLoader()),
                ],
              ),
            );
          } else if (state is WalletError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      context.read<WalletBloc>().add(const LoadWallet());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (state is WalletLoaded) {
            final balance = state.balance;
            final transactions = state.transactions;
            return RefreshIndicator(
              onRefresh: () async {
                context.read<WalletBloc>().add(const RefreshWallet());
              },
              child: ResponsiveLayout(
                mobileLayout: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverAppBar(
                      floating: true,
                      snap: true,
                      expandedHeight: 150,
                      elevation: 0,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: BalanceCard(balance: balance, isMobile: true),
                        ),
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: FilterChips(
                          currentFilter: state.currentFilter,
                          onFilterSelected: (type) {
                            context.read<WalletBloc>().add(
                              FilterTransactions(type),
                            );
                          },
                        ),
                      ),
                    ),

                    if (transactions.isEmpty)
                      const SliverToBoxAdapter(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text('No transactions found'),
                          ),
                        ),
                      )
                    else
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 30,
                        ),
                        sliver: SliverList.builder(
                          itemBuilder: (context, index) {
                            if (index < transactions.length) {
                              final transaction = transactions[index];
                              return TransactionItem(item: transaction);
                            } else if (state.hasNext) {
                              return const TransItemLoader();
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                          itemCount:
                              transactions.length +
                              (state.isLoadingMore ? 1 : 0),
                        ),
                      ),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

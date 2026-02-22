import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loynova_assessment/core/di/injection.dart';
import 'package:loynova_assessment/core/utils/responsive_layout.dart';

import '../../../../core/utils/translations_keys.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../manager/wallet_bloc.dart';
import '../manager/wallet_event.dart';
import '../manager/wallet_states.dart';
import '../widgets/balance_card.dart';
import '../widgets/filter_chips.dart';
import '../widgets/transaction_item.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.tr(TranslationsKeys.wallet))),
      body: BlocProvider(
        create: (context) =>
            WalletBloc(getIt<WalletRepository>())..add(const LoadWallet()),
        child: BlocBuilder<WalletBloc, WalletState>(
          builder: (context, state) {
            if (state is WalletLoading) {
              return const Center(child: CircularProgressIndicator());
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
                    slivers: [
                      SliverAppBar(
                        // pinned: true,
                        floating: true,
                        snap: true,
                        expandedHeight: 200,
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Padding(
                            padding: const EdgeInsets.all(16),
                            child: BalanceCard(
                              balance: balance,
                              isMobile: true,
                            ),
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

                      const SliverToBoxAdapter(child: SizedBox(height: 16)),

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
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              if (index < transactions.length) {
                                final transaction = transactions[index];
                                return TransactionItem(item: transaction);
                              } else if (state.hasNext) {
                                context.read<WalletBloc>().add(
                                  const LoadMoreTransactions(),
                                );
                                return const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            },
                            childCount:
                                transactions.length + (state.hasNext ? 1 : 0),
                          ),
                        ),

                      const SliverToBoxAdapter(child: SizedBox(height: 16)),
                    ],
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}

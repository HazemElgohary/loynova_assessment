import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loynova_assessment/core/di/injection.dart';
import 'package:loynova_assessment/core/utils/responsive_layout.dart';

import '../../../../core/utils/translations_keys.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../manager/wallet_bloc.dart';
import '../manager/wallet_event.dart';
import '../manager/wallet_states.dart';
import '../widgets/balance_card.dart';
import '../widgets/filter_chips.dart';
import '../widgets/transaction_list.dart';

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
                  mobileLayout: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BalanceCard(balance: balance, isMobile: true),
                          const SizedBox(height: 16),
                          FilterChips(
                            currentFilter: state.currentFilter,
                            onFilterSelected: (type) {
                              context.read<WalletBloc>().add(
                                FilterTransactions(type),
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          TransactionList(
                            transactions: transactions,
                            hasNext: state.hasNext,
                            onLoadMore: () {
                              context.read<WalletBloc>().add(
                                const LoadMoreTransactions(),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
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

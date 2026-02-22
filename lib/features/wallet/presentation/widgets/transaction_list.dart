import 'package:flutter/material.dart';
import 'package:loynova_assessment/core/utils/extentions/date_time.dart';
import 'package:loynova_assessment/features/wallet/domain/entities/transaction_entity.dart';
import 'package:loynova_assessment/features/wallet/presentation/widgets/transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<TransactionEntity> transactions;
  final bool hasNext;
  final VoidCallback onLoadMore;

  const TransactionList({
    super.key,
    required this.transactions,
    required this.hasNext,
    required this.onLoadMore,
  });

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return const Center(child: Text('No transactions found'));
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: hasNext ? transactions.length + 1 : transactions.length,
      itemBuilder: (context, index) {
        if (index >= transactions.length) {
          onLoadMore();
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final item = transactions[index];
        return TransactionItem(item: item);
      },
    );
  }
}

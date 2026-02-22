import 'package:equatable/equatable.dart';
import 'package:loynova_assessment/features/wallet/domain/entities/transaction_entity.dart';

class PaginatedTransactionsModel extends Equatable {
  final List<TransactionEntity> transactions;
  final int page;
  final int totalItems;
  final bool hasNext;

  const PaginatedTransactionsModel({
    required this.transactions,
    required this.page,
    required this.totalItems,
    required this.hasNext,
  });

  @override
  List<Object?> get props => [transactions, page, totalItems, hasNext];
}

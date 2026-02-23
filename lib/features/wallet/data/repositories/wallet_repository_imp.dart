import 'package:loynova_assessment/core/constants.dart';
import 'package:loynova_assessment/features/wallet/data/models/paginated_transactions_model.dart';
import 'package:loynova_assessment/features/wallet/domain/entities/points_balance_entity.dart';
import 'package:loynova_assessment/features/wallet/domain/entities/transaction_entity.dart';

import '../../../../core/utils/enums.dart';
import '../../domain/repositories/wallet_repository.dart';

/// * Mocked Implementation of the WalletRepository
class MockWalletRepository implements WalletRepository {
  final List<TransactionEntity> _transactions;

  MockWalletRepository(this._transactions);

  @override
  Future<PointsBalanceEntity> getBalance() async {
    await Future.delayed(const Duration(milliseconds: 800));

    // return PointsBalanceEntity(
    //   totalPoints: 15750,
    //   pendingPoints: 500,
    //   expiringPoints: 1200,
    //   expiringDate: DateTime(2024, 3, 31),
    //   lastUpdated: DateTime(2024, 2, 15),
    //   balancesByMerchant: const [],
    // );
    return Constants.mockBalance;
  }

  @override
  Future<PaginatedTransactionsModel> getTransactions({
    int page = 1,
    int limit = 20,
    TransactionType? type,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    var filtered = _transactions;

    if (type != null) {
      filtered = filtered.where((t) => t.type == type).toList();
    }

    final start = (page - 1) * limit;
    if (start >= filtered.length) {
      return PaginatedTransactionsModel(
        transactions: const [],
        page: page,
        totalItems: filtered.length,
        hasNext: false,
      );
    }
    final end = (start + limit).clamp(0, filtered.length);

    return PaginatedTransactionsModel(
      transactions: filtered.sublist(start, end),
      page: page,
      totalItems: filtered.length,
      hasNext: end < filtered.length,
    );
  }
}

import 'package:loynova_assessment/features/wallet/domain/entities/points_balance_entity.dart';

import '../../../../core/utils/enums.dart';
import '../../data/models/paginated_transactions_model.dart';

abstract class WalletRepository {
  Future<PointsBalanceEntity> getBalance();

  Future<PaginatedTransactionsModel> getTransactions({
    int page,
    int limit,
    TransactionType? type,
  });
}

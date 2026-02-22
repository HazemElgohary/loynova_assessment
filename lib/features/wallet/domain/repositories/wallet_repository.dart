import 'package:loynova_assessment/features/wallet/domain/entities/points_balance_entity.dart';
import 'package:loynova_assessment/features/wallet/domain/entities/transfer_result_entity.dart';

import '../../../../core/utils/enums.dart';
import '../../data/dtos/transfer_request_dto.dart';
import '../../data/models/paginated_transactions_model.dart';
import '../entities/transaction_entity.dart';

abstract class WalletRepository {
  Future<PointsBalanceEntity> getBalance();

  Future<PaginatedTransactionsModel> getTransactions({
    int page,
    int limit,
    TransactionType? type,
  });

  Future<TransferResultEntity> transferPoints(TransferRequestDto requestDto);
}

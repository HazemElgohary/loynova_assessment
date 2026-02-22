import '../../../../core/exceptions/app_exception.dart';
import '../../../wallet/data/dtos/transfer_request_dto.dart';
import '../../../wallet/domain/entities/transfer_result_entity.dart';
import '../../domain/repositories/transfer_repository.dart';

class TransferRepositoryImp extends TransferRepository {
  @override
  Future<TransferResultEntity> transferPoints(
    TransferRequestDto request,
  ) async {
    await Future.delayed(const Duration(seconds: 1));

    if (request.points > 15750) {
      throw ValidationException('INSUFFICIENT_BALANCE');
    }

    return TransferResultEntity(
      transactionId: DateTime.now().millisecondsSinceEpoch.toString(),
      points: request.points,
      description: request.recipient,
      newBalance: 15750 - request.points,
      status: 'COMPLETED',
    );
  }
}

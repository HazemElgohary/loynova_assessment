import '../../../wallet/data/dtos/transfer_request_dto.dart';
import '../../../wallet/domain/entities/transfer_result_entity.dart';

abstract class TransferRepository {
  Future<TransferResultEntity> transferPoints({
    required TransferRequestDto requestDto,
    int? availableBalance,
  });
}

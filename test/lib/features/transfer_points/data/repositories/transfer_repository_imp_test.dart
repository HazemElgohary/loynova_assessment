import 'package:flutter_test/flutter_test.dart';
import 'package:loynova_assessment/core/exceptions/app_exception.dart';
import 'package:loynova_assessment/features/transfer_points/data/repositories/transfer_repository_imp.dart';
import 'package:loynova_assessment/features/wallet/data/dtos/transfer_request_dto.dart';
import 'package:loynova_assessment/features/wallet/domain/entities/transfer_result_entity.dart';

void main() {
  late TransferRepositoryImp repository;
  late TransferResultEntity mockedResult;
  late int availableBalance;
  late int points;
  late String recipient;

  setUp(() {
    repository = TransferRepositoryImp();
    availableBalance = 15750;
    points = 750;
    recipient = 'test@test.com';
    mockedResult = TransferResultEntity(
      transactionId: DateTime.now().millisecondsSinceEpoch.toString(),
      points: points,
      description: recipient,
      newBalance: availableBalance - points,
      status: 'COMPLETED',
    );
  });

  group('transferPoints', () {
    test('transfer success updates balance', () async {
      final result = await repository.transferPoints(
        requestDto: TransferRequestDto(
          recipient: recipient,
          points: points,
          note: 'any description',
        ),
        availableBalance: availableBalance,
      );

      expect(result.points, points);
      expect(result.newBalance, lessThan(availableBalance));
    });

    test('throws insufficient balance', () async {
      expect(
        () => repository.transferPoints(
          requestDto: TransferRequestDto(
            recipient: recipient,
            points: 9999999,
            note: 'any description',
          ),
          availableBalance: availableBalance,
        ),
        throwsA(isA<ValidationException>()),
      );
    });
  });
}

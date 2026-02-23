import 'package:flutter_test/flutter_test.dart';
import 'package:loynova_assessment/core/constants.dart';
import 'package:loynova_assessment/core/utils/enums.dart';
import 'package:loynova_assessment/features/wallet/data/repositories/wallet_repository_imp.dart';
import 'package:loynova_assessment/features/wallet/domain/entities/points_balance_entity.dart';

void main() {
  late MockWalletRepository repository;
  late PointsBalanceEntity mockedBalance;

  setUp(() {
    repository = MockWalletRepository(Constants.mockTransactions);
    mockedBalance = Constants.mockBalance;
  });

  group('getBalance', () {
    test('returns correct balance data', () async {
      final result = await repository.getBalance();

      expect(result.totalPoints, mockedBalance.totalPoints);
      expect(result.pendingPoints, mockedBalance.pendingPoints);
      expect(
        result.balancesByMerchant.length,
        mockedBalance.balancesByMerchant.length,
      );
    });
  });

  group('getTransactions', () {
    test('returns paginated data', () async {
      final result = await repository.getTransactions(limit: 2);

      expect(result.transactions.length, 2);
      expect(result.page, 1);
      expect(result.hasNext, true);
    });

    test('filters by type correctly', () async {
      final result = await repository.getTransactions(
        type: TransactionType.earn,
      );

      expect(
        result.transactions.every((t) => t.type == TransactionType.earn),
        true,
      );
    });

    test('returns empty when page exceeds limit', () async {
      final result = await repository.getTransactions(page: 999);

      expect(result.transactions.isEmpty, true);
    });
  });
}

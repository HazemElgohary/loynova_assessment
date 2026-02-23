import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loynova_assessment/core/constants.dart';
import 'package:loynova_assessment/core/utils/enums.dart';
import 'package:loynova_assessment/features/wallet/data/models/paginated_transactions_model.dart';
import 'package:loynova_assessment/features/wallet/domain/entities/points_balance_entity.dart';
import 'package:loynova_assessment/features/wallet/domain/repositories/wallet_repository.dart';
import 'package:loynova_assessment/features/wallet/presentation/manager/wallet_bloc.dart';
import 'package:loynova_assessment/features/wallet/presentation/manager/wallet_event.dart';
import 'package:loynova_assessment/features/wallet/presentation/manager/wallet_states.dart';
import 'package:mocktail/mocktail.dart';

class MockWalletRepository extends Mock implements WalletRepository {}

void main() {
  late WalletBloc bloc;
  late MockWalletRepository repository;
  late PointsBalanceEntity mockedBalance;
  late PaginatedTransactionsModel mockedPaginated;

  setUp(() {
    repository = MockWalletRepository();
    bloc = WalletBloc(repository);
    mockedBalance = Constants.mockBalance;
    mockedPaginated = PaginatedTransactionsModel(
      transactions: Constants.mockTransactions,
      page: 1,
      totalItems: Constants.mockTransactions.length,
      hasNext: false,
    );
  });

  tearDown(() {
    bloc.close();
  });

  test('initial state is WalletInitial', () {
    expect(bloc.state, isA<WalletInitial>());
  });

  group('LoadWallet', () {
    blocTest<WalletBloc, WalletState>(
      'emits [Loading, Loaded] when successful',
      build: () {
        when(
          () => repository.getBalance(),
        ).thenAnswer((_) async => mockedBalance);
        when(
          () => repository.getTransactions(page: 1, limit: 10),
        ).thenAnswer((_) async => mockedPaginated);

        return bloc;
      },
      act: (bloc) => bloc.add(const LoadWallet()),
      expect: () => [isA<WalletLoading>(), isA<WalletLoaded>()],
    );

    blocTest<WalletBloc, WalletState>(
      'emits [Loading, Error] when exception thrown',
      build: () {
        when(() => repository.getBalance()).thenThrow(Exception('error'));

        return bloc;
      },
      act: (bloc) => bloc.add(const LoadWallet()),
      expect: () => [isA<WalletLoading>(), isA<WalletError>()],
    );
  });

  group('FilterTransactions', () {
    blocTest<WalletBloc, WalletState>(
      'filters correctly',
      build: () {
        when(
          () => repository.getBalance(),
        ).thenAnswer((_) async => mockedBalance);
        when(
          () => repository.getTransactions(page: 1, limit: 10),
        ).thenAnswer((_) async => mockedPaginated);

        when(
          () => repository.getTransactions(page: 1),
        ).thenAnswer((_) async => mockedPaginated);

        return bloc;
      },
      act: (bloc) async {
        bloc.add(const LoadWallet());
        await Future.delayed(Duration.zero);
        bloc.add(const FilterTransactions(null));
      },
      expect: () => [isA<WalletLoading>(), isA<WalletLoaded>()],
    );
  });

  group('RefreshWallet', () {
    blocTest<WalletBloc, WalletState>(
      'reloads data',
      build: () {
        when(
          () => repository.getBalance(),
        ).thenAnswer((_) async => mockedBalance);
        when(
          () => repository.getTransactions(page: 1, limit: 10),
        ).thenAnswer((_) async => mockedPaginated);

        return bloc;
      },
      act: (bloc) => bloc.add(const RefreshWallet()),
      expect: () => [isA<WalletLoading>(), isA<WalletLoaded>()],
    );
  });
}

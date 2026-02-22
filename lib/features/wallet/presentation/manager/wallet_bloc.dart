import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loynova_assessment/features/wallet/domain/entities/transaction_entity.dart';
import 'package:loynova_assessment/features/wallet/presentation/manager/wallet_event.dart';
import 'package:loynova_assessment/features/wallet/presentation/manager/wallet_states.dart';

import '../../../../core/utils/enums.dart';
import '../../domain/repositories/wallet_repository.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletRepository repository;

  int _currentPage = 1;
  bool _hasNext = true;
  List<TransactionEntity> _allTransactions = [];
  TransactionType? _currentFilter;

  WalletBloc(this.repository) : super(WalletInitial()) {
    on<LoadWallet>(_onLoadWallet);
    on<RefreshWallet>(_onRefreshWallet);
    on<FilterTransactions>(_onFilterTransactions);
    on<LoadMoreTransactions>(_onLoadMoreTransactions);
  }

  Future<void> _onLoadWallet(
    LoadWallet event,
    Emitter<WalletState> emit,
  ) async {
    emit(WalletLoading());
    _currentPage = 1;
    _hasNext = true;

    try {
      final balance = await repository.getBalance();
      final txns = await repository.getTransactions(page: _currentPage);
      _allTransactions = txns.transactions;
      _hasNext = txns.hasNext;

      emit(
        WalletLoaded(
          balance: balance,
          transactions: _allTransactions,
          hasNext: _hasNext,
          currentFilter: _currentFilter,
        ),
      );
    } catch (e) {
      emit(WalletError(e.toString()));
    }
  }

  Future<void> _onRefreshWallet(
    RefreshWallet event,
    Emitter<WalletState> emit,
  ) async {
    _currentPage = 1;
    _hasNext = true;
    add(const LoadWallet());
  }

  Future<void> _onFilterTransactions(
    FilterTransactions event,
    Emitter<WalletState> emit,
  ) async {
    _currentFilter = event.type;
    try {
      final txns = await repository.getTransactions(
        page: 1,
        type: _currentFilter,
      );
      _allTransactions = txns.transactions;
      _hasNext = txns.hasNext;

      if (state is WalletLoaded) {
        final balance = (state as WalletLoaded).balance;
        emit(
          WalletLoaded(
            balance: balance,
            transactions: _allTransactions,
            hasNext: _hasNext,
            currentFilter: _currentFilter,
          ),
        );
      }
    } catch (e) {
      emit(WalletError(e.toString()));
    }
  }

  Future<void> _onLoadMoreTransactions(
    LoadMoreTransactions event,
    Emitter<WalletState> emit,
  ) async {
    if (!_hasNext || state is WalletLoading) return;

    if (state is WalletLoaded) {
      final currentState = state as WalletLoaded;
      emit(WalletLoading());

      try {
        _currentPage++;
        final txns = await repository.getTransactions(
          page: _currentPage,
          type: _currentFilter,
        );

        _allTransactions.addAll(txns.transactions);
        _hasNext = txns.hasNext;

        emit(
          WalletLoaded(
            balance: currentState.balance,
            transactions: _allTransactions,
            hasNext: _hasNext,
            currentFilter: _currentFilter,
          ),
        );
      } catch (e) {
        emit(WalletError(e.toString()));
      }
    }
  }
}

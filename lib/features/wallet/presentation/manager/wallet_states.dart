import 'package:equatable/equatable.dart';
import 'package:loynova_assessment/features/wallet/domain/entities/points_balance_entity.dart';
import 'package:loynova_assessment/features/wallet/domain/entities/transaction_entity.dart';

import '../../../../core/utils/enums.dart';

abstract class WalletState extends Equatable {
  const WalletState();
}

class WalletInitial extends WalletState {
  @override
  List<Object?> get props => [];
}

class WalletLoading extends WalletState {
  @override
  List<Object?> get props => [];
}

class WalletLoaded extends WalletState {
  final PointsBalanceEntity balance;
  final List<TransactionEntity> transactions;
  final bool hasNext;
  final TransactionType? currentFilter;

  const WalletLoaded({
    required this.balance,
    required this.transactions,
    required this.hasNext,
    this.currentFilter,
  });

  @override
  List<Object?> get props => [balance, transactions, hasNext, currentFilter];
}

class WalletError extends WalletState {
  final String message;

  const WalletError(this.message);

  @override
  List<Object?> get props => [message];
}

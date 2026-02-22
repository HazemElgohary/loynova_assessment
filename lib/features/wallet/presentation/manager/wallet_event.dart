import 'package:equatable/equatable.dart';
import '../../../../core/utils/enums.dart';

abstract class WalletEvent extends Equatable {
  const WalletEvent();
}

class LoadWallet extends WalletEvent {
  const LoadWallet();
  @override
  List<Object?> get props => [];
}

class RefreshWallet extends WalletEvent {
  const RefreshWallet();
  @override
  List<Object?> get props => [];
}

class FilterTransactions extends WalletEvent {
  final TransactionType? type;
  const FilterTransactions(this.type);

  @override
  List<Object?> get props => [type];
}

class LoadMoreTransactions extends WalletEvent {
  const LoadMoreTransactions();
  @override
  List<Object?> get props => [];
}

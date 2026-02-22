import 'package:equatable/equatable.dart';
import 'package:loynova_assessment/features/wallet/domain/entities/transfer_result_entity.dart';
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

class ApplyTransferLocally extends WalletEvent {
  final TransferResultEntity result;

  const ApplyTransferLocally(this.result);

  @override
  List<Object?> get props => [result];
}

import 'package:equatable/equatable.dart';
import 'package:loynova_assessment/features/wallet/domain/entities/transfer_result_entity.dart';

abstract class TransferState extends Equatable {
  const TransferState();

  @override
  List<Object?> get props => [];
}

/// Initial
class TransferInitial extends TransferState {}

/// Loading
class TransferLoading extends TransferState {}

/// Success
class TransferSuccess extends TransferState {
  final TransferResultEntity result;

  const TransferSuccess(this.result);

  @override
  List<Object?> get props => [result];
}

/// Error
class TransferError extends TransferState {
  final String message;

  const TransferError(this.message);

  @override
  List<Object?> get props => [message];
}

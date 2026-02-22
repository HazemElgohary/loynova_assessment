import 'package:equatable/equatable.dart';
import 'package:loynova_assessment/features/wallet/data/dtos/transfer_request_dto.dart';

abstract class TransferEvent extends Equatable {
  const TransferEvent();

  @override
  List<Object?> get props => [];
}

class SubmitTransfer extends TransferEvent {
  final TransferRequestDto request;

  const SubmitTransfer(this.request);

  @override
  List<Object?> get props => [request];
}

class ResetTransfer extends TransferEvent {}

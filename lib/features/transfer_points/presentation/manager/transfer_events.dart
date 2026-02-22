import 'package:equatable/equatable.dart';

abstract class TransferEvent extends Equatable {
  const TransferEvent();

  @override
  List<Object?> get props => [];
}

class RecipientChanged extends TransferEvent {
  final String value;

  const RecipientChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class PointsChanged extends TransferEvent {
  final String value;

  const PointsChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class NoteChanged extends TransferEvent {
  final String value;

  const NoteChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class SubmitTransfer extends TransferEvent {
  const SubmitTransfer();
}

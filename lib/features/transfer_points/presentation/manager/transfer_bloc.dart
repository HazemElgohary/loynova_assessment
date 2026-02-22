import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loynova_assessment/core/utils/validators.dart';
import 'package:loynova_assessment/features/transfer_points/data/models/note_model.dart';
import 'package:loynova_assessment/features/transfer_points/data/models/points_model.dart';
import 'package:loynova_assessment/features/transfer_points/data/models/recipient_model.dart';
import 'package:loynova_assessment/features/transfer_points/presentation/manager/transfer_events.dart';
import 'package:loynova_assessment/features/transfer_points/presentation/manager/transfer_state.dart';
import 'package:loynova_assessment/features/wallet/data/dtos/transfer_request_dto.dart';

import '../../domain/repositories/transfer_repository.dart';

class TransferBloc extends Bloc<TransferEvent, TransferState> {
  final TransferRepository repository;
  final int availableBalance;

  TransferBloc({required this.repository, required this.availableBalance})
    : super(const TransferState()) {
    on<RecipientChanged>(_onRecipientChanged);
    on<PointsChanged>(_onPointsChanged);
    on<NoteChanged>(_onNoteChanged);
    on<SubmitTransfer>(_onSubmitTransfer);
  }

  void _onRecipientChanged(
    RecipientChanged event,
    Emitter<TransferState> emit,
  ) {
    final error = (event.value.isEmpty)
        ? 'Recipient required'
        : (!Validators.isValidEgyptianPhone(event.value) &&
              !Validators.isValidEmail(event.value))
        ? 'Invalid phone/email'
        : null;

    final recipient = state.recipient.copyWith(
      value: event.value,
      error: error,
    );
    emit(
      state.copyWith(
        recipient: recipient,
        isFormValid: _validateForm(recipient, state.points, state.note),
      ),
    );
  }

  void _onPointsChanged(PointsChanged event, Emitter<TransferState> emit) {
    final pointsValue = int.tryParse(event.value);
    String? error;

    if (event.value.isEmpty) {
      error = 'Points required';
    } else if (pointsValue == null) {
      error = 'Whole numbers only';
    } else if (pointsValue < 100) {
      error = 'Min 100 points';
    } else if (pointsValue > availableBalance) {
      error = 'Exceeds balance';
    }

    final points = state.points.copyWith(value: event.value, error: error);

    emit(
      state.copyWith(
        points: points,
        isFormValid: _validateForm(state.recipient, points, state.note),
      ),
    );
  }

  void _onNoteChanged(NoteChanged event, Emitter<TransferState> emit) {
    final error = (event.value.length > 150) ? 'Max 150 chars' : null;
    final note = state.note.copyWith(value: event.value, error: error);

    emit(
      state.copyWith(
        note: note,
        isFormValid: _validateForm(state.recipient, state.points, note),
      ),
    );
  }

  bool _validateForm(
    RecipientModel recipient,
    PointsModel points,
    NoteModel note,
  ) {
    return recipient.isValid && points.isValid && note.isValid;
  }

  Future<void> _onSubmitTransfer(
    SubmitTransfer event,
    Emitter<TransferState> emit,
  ) async {
    if (!state.isFormValid) return;

    emit(state.copyWith(isSubmitting: true));

    try {
      final request = TransferRequestDto(
        recipient: state.recipient.value,
        points: int.parse(state.points.value),
        note: state.note.value.isEmpty ? null : state.note.value,
      );

      final result = await repository.transferPoints(request);

      emit(state.copyWith(isSubmitting: false, result: result));
    } catch (e) {
      emit(state.copyWith(isSubmitting: false, error: e.toString()));
    }
  }
}

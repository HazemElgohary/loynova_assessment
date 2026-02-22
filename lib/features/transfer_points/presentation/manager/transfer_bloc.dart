import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loynova_assessment/features/transfer_points/presentation/manager/transfer_events.dart';
import 'package:loynova_assessment/features/transfer_points/presentation/manager/transfer_state.dart';

import '../../domain/repositories/transfer_repository.dart';

class TransferBloc extends Bloc<TransferEvent, TransferState> {
  final TransferRepository repository;

  TransferBloc(this.repository) : super(TransferInitial()) {
    on<SubmitTransfer>(_onSubmitTransfer);
  }

  Future<void> _onSubmitTransfer(
    SubmitTransfer event,
    Emitter<TransferState> emit,
  ) async {
    emit(TransferLoading());

    try {
      final result = await repository.transferPoints(event.request);
      emit(TransferSuccess(result));
    } catch (e) {
      emit(TransferError(e.toString()));
    }
  }
}

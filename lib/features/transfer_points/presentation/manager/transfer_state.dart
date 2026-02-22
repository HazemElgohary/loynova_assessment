import 'package:equatable/equatable.dart';
import 'package:loynova_assessment/features/transfer_points/data/models/note_model.dart';
import 'package:loynova_assessment/features/transfer_points/data/models/points_model.dart';
import 'package:loynova_assessment/features/transfer_points/data/models/recipient_model.dart';
import 'package:loynova_assessment/features/wallet/domain/entities/transfer_result_entity.dart';

class TransferState extends Equatable {
  final RecipientModel recipient;
  final PointsModel points;
  final NoteModel note;
  final bool isSubmitting;
  final bool isFormValid;
  final TransferResultEntity? result;
  final String? error;

  const TransferState({
    this.recipient = const RecipientModel(),
    this.points = const PointsModel(),
    this.note = const NoteModel(),
    this.isSubmitting = false,
    this.isFormValid = false,
    this.result,
    this.error,
  });

  TransferState copyWith({
    RecipientModel? recipient,
    PointsModel? points,
    NoteModel? note,
    bool? isSubmitting,
    bool? isFormValid,
    TransferResultEntity? result,
    String? error,
  }) {
    return TransferState(
      recipient: recipient ?? this.recipient,
      points: points ?? this.points,
      note: note ?? this.note,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isFormValid: isFormValid ?? this.isFormValid,
      result: result ?? this.result,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    recipient,
    points,
    note,
    isSubmitting,
    isFormValid,
    result,
    error,
  ];
}

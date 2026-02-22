import 'package:equatable/equatable.dart';

class TransferRequestDto extends Equatable {
  final String recipient;
  final int points;
  final String? note;

  const TransferRequestDto({
    required this.recipient,
    required this.points,
    this.note,
  });

  Map<String, dynamic> toJson() => {
    'recipient': recipient,
    'points': points,
    'note': note,
  };

  @override
  List<Object?> get props => [recipient, points, note];
}

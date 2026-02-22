import 'package:equatable/equatable.dart';

class TransferResultEntity extends Equatable {
  final String transactionId;
  final int points;
  final int newBalance;
  final String status;

  const TransferResultEntity({
    required this.transactionId,
    required this.points,
    required this.newBalance,
    required this.status,
  });

  @override
  List<Object?> get props => [transactionId, points, newBalance, status];
}

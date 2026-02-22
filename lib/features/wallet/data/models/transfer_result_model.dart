import 'package:equatable/equatable.dart';

import '../../domain/entities/transfer_result_entity.dart';

class TransferResultModel extends TransferResultEntity {
  const TransferResultModel({
    required super.transactionId,
    required super.points,
    required super.newBalance,
    required super.status,
  });

  @override
  List<Object?> get props => [transactionId, points, newBalance, status];

  Map<String, dynamic> toJson() => {
    'transactionId': transactionId,
    'points': points,
    'newBalance': newBalance,
    'status': status,
  };

  factory TransferResultModel.fromJson(Map<String, dynamic> json) {
    return TransferResultModel(
      transactionId: json['transactionId'],
      points: json['points'],
      newBalance: json['newBalance'],
      status: json['status'],
    );
  }
}

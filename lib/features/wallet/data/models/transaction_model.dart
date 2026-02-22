import '../../../../core/utils/enums.dart';
import '../../domain/entities/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  const TransactionModel({
    required super.id,
    required super.type,
    required super.points,
    required super.description,
    super.merchantName,
    super.merchantLogo,
    required super.createdAt,
    required super.status,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as String,
      type: _transactionTypeFromString(json['type'] as String),
      points: json['points'] as int,
      description: json['description'] as String,
      merchantName: json['merchantName'] as String?,
      merchantLogo: json['merchantLogo'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      status: _transactionStatusFromString(json['status'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'points': points,
      'description': description,
      'merchantName': merchantName,
      'merchantLogo': merchantLogo,
      'createdAt': createdAt.toIso8601String(),
      'status': status.name,
    };
  }

  static TransactionType _transactionTypeFromString(String type) {
    return TransactionType.values.firstWhere(
      (e) => e.name.toLowerCase() == type.toLowerCase(),
      orElse: () => TransactionType.earn,
    );
  }

  static TransactionStatus _transactionStatusFromString(String status) {
    return TransactionStatus.values.firstWhere(
      (e) => e.name.toLowerCase() == status.toLowerCase(),
      orElse: () => TransactionStatus.pending,
    );
  }
}

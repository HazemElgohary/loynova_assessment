import 'package:equatable/equatable.dart';

import '../../../../core/utils/enums.dart';

class TransactionEntity extends Equatable {
  final String id;
  final TransactionType type;
  final int points;
  final String description;
  final String? merchantName;
  final String? merchantLogo;
  final DateTime createdAt;
  final TransactionStatus status;

  const TransactionEntity({
    required this.id,
    required this.type,
    required this.points,
    required this.description,
    this.merchantName,
    this.merchantLogo,
    required this.createdAt,
    required this.status,
  });

  TransactionEntity copyWith({
    String? id,
    TransactionType? type,
    int? points,
    String? description,
    String? merchantName,
    String? merchantLogo,
    DateTime? createdAt,
    TransactionStatus? status,
  }) {
    return TransactionEntity(
      id: id ?? this.id,
      type: type ?? this.type,
      points: points ?? this.points,
      description: description ?? this.description,
      merchantName: merchantName ?? this.merchantName,
      merchantLogo: merchantLogo ?? this.merchantLogo,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
    id,
    type,
    points,
    description,
    merchantName,
    merchantLogo,
    createdAt,
    status,
  ];
}

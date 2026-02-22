import '../../domain/entities/points_balance_entity.dart';
import 'merchant_balance_model.dart';

class PointsBalanceModel extends PointsBalanceEntity {
  const PointsBalanceModel({
    required super.totalPoints,
    required super.pendingPoints,
    required super.expiringPoints,
    required super.expiringDate,
    required super.lastUpdated,
    required super.balancesByMerchant,
  });

  factory PointsBalanceModel.fromJson(Map<String, dynamic> json) {
    return PointsBalanceModel(
      totalPoints: json['totalPoints'] as int,
      pendingPoints: json['pendingPoints'] as int,
      expiringPoints: json['expiringPoints'] as int,
      expiringDate: DateTime.parse(json['expiringDate'] as String),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      balancesByMerchant: (json['balancesByMerchant'] as List<dynamic>)
          .map((e) => MerchantBalanceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalPoints': totalPoints,
      'pendingPoints': pendingPoints,
      'expiringPoints': expiringPoints,
      'expiringDate': expiringDate.toIso8601String(),
      'lastUpdated': lastUpdated.toIso8601String(),
      'balancesByMerchant': balancesByMerchant
          .map((e) => (e as MerchantBalanceModel).toJson())
          .toList(),
    };
  }
}

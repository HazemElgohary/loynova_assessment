import '../../domain/entities/merchant_balance_entity.dart';

class MerchantBalanceModel extends MerchantBalanceEntity {
  const MerchantBalanceModel({
    required super.merchantId,
    required super.merchantName,
    required super.merchantLogo,
    required super.points,
    required super.tier,
  });

  factory MerchantBalanceModel.fromJson(Map<String, dynamic> json) {
    return MerchantBalanceModel(
      merchantId: json['merchantId'] as String,
      merchantName: json['merchantName'] as String,
      merchantLogo: json['merchantLogo'] as String,
      points: json['points'] as int,
      tier: json['tier'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'merchantId': merchantId,
      'merchantName': merchantName,
      'merchantLogo': merchantLogo,
      'points': points,
      'tier': tier,
    };
  }
}

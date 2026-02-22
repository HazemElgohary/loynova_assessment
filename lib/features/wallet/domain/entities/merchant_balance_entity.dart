import 'package:equatable/equatable.dart';

class MerchantBalanceEntity extends Equatable {
  final String merchantId;
  final String merchantName;
  final String merchantLogo;
  final int points;
  final String tier;

  const MerchantBalanceEntity({
    required this.merchantId,
    required this.merchantName,
    required this.merchantLogo,
    required this.points,
    required this.tier,
  });

  MerchantBalanceEntity copyWith({
    String? merchantId,
    String? merchantName,
    String? merchantLogo,
    int? points,
    String? tier,
  }) {
    return MerchantBalanceEntity(
      merchantId: merchantId ?? this.merchantId,
      merchantName: merchantName ?? this.merchantName,
      merchantLogo: merchantLogo ?? this.merchantLogo,
      points: points ?? this.points,
      tier: tier ?? this.tier,
    );
  }

  @override
  List<Object> get props => [
    merchantId,
    merchantName,
    merchantLogo,
    points,
    tier,
  ];
}

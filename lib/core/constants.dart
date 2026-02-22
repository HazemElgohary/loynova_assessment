import 'package:loynova_assessment/core/utils/enums.dart';
import 'package:loynova_assessment/features/wallet/domain/entities/merchant_balance_entity.dart';
import 'package:loynova_assessment/features/wallet/domain/entities/points_balance_entity.dart';
import 'package:loynova_assessment/features/wallet/domain/entities/transaction_entity.dart';

class Constants {
  static const appName = 'Shop_Plus';
  static const animationDuration = Duration(milliseconds: 1500);
  static const int mobileLayoutSize = 600;
  static const int tabletLayoutSize = 1200;

  // Balance
  static final mockBalance = PointsBalanceEntity(
    totalPoints: 15750,
    pendingPoints: 500,
    expiringPoints: 1200,
    expiringDate: DateTime.parse('2024-03-31T23:59:59Z'),
    lastUpdated: DateTime.parse('2024-02-15T10:30:00Z'),
    balancesByMerchant: const [
      MerchantBalanceEntity(
        merchantId: 'm_123',
        merchantName: 'TechMart',
        merchantLogo: 'https://picsum.photos/seed/techmart/100',
        points: 8500,
        tier: 'Gold',
      ),
      MerchantBalanceEntity(
        merchantId: 'm_456',
        merchantName: 'FoodMart',
        merchantLogo: 'https://picsum.photos/seed/foodmart/100',
        points: 4250,
        tier: 'Silver',
      ),
      MerchantBalanceEntity(
        merchantId: 'm_789',
        merchantName: 'StyleHub',
        merchantLogo: 'https://picsum.photos/seed/stylehub/100',
        points: 3000,
        tier: 'Bronze',
      ),
    ],
  );

  // Transactions
  static final mockTransactions = [
    TransactionEntity(
      id: 'txn_001',
      type: TransactionType.earn,
      points: 500,
      description: 'Purchase at TechMart',
      merchantName: 'TechMart',
      merchantLogo: 'https://picsum.photos/seed/techmart/100',
      createdAt: DateTime.parse('2024-02-15T14:30:00Z'),
      status: TransactionStatus.completed,
    ),
    TransactionEntity(
      id: 'txn_002',
      type: TransactionType.redeem,
      points: -1000,
      description: 'Discount redemption',
      merchantName: 'FoodMart',
      merchantLogo: 'https://picsum.photos/seed/foodmart/100',
      createdAt: DateTime.parse('2024-02-14T11:20:00Z'),
      status: TransactionStatus.completed,
    ),
    TransactionEntity(
      id: 'txn_003',
      type: TransactionType.transferOut,
      points: -250,
      description: 'Transfer to Ahmed M.',

      createdAt: DateTime.parse('2024-02-13T09:15:00Z'),
      status: TransactionStatus.completed,
    ),
    TransactionEntity(
      id: 'txn_004',
      type: TransactionType.purchase,
      points: 750,
      description: 'Online order #ORD-2024-089',
      merchantName: 'StyleHub',
      merchantLogo: 'https://picsum.photos/seed/stylehub/100',
      createdAt: DateTime.parse('2024-02-12T16:45:00Z'),
      status: TransactionStatus.completed,
    ),
    TransactionEntity(
      id: 'txn_005',
      type: TransactionType.transferIn,
      points: 300,
      description: 'Received from Sara K.',
      createdAt: DateTime.parse('2024-02-08T13:30:00Z'),
      status: TransactionStatus.pending,
    ),
  ];
}

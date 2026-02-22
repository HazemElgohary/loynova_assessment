import '../enums.dart';

extension TransactionTypeX on TransactionType {
  String get displayName {
    switch (this) {
      case TransactionType.earn:
        return 'Earn';
      case TransactionType.redeem:
        return 'Redeem';
      case TransactionType.transferIn:
        return 'Transfer In';
      case TransactionType.transferOut:
        return 'Transfer Out';
      case TransactionType.purchase:
        return 'Purchase';
    }
  }
}

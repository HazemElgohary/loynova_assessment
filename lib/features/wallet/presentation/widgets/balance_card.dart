import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/translations_keys.dart';
import '../../domain/entities/points_balance_entity.dart';

class BalanceCard extends StatelessWidget {
  final PointsBalanceEntity balance;
  final bool isMobile;

  const BalanceCard({super.key, required this.balance, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF6C5CE7),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${balance.totalPoints} ${context.tr(TranslationsKeys.pts)}',
              style: TextStyle(
                color: Colors.white,
                fontSize: isMobile ? 24 : 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              context.tr(TranslationsKeys.totalBalance),
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${context.tr(TranslationsKeys.pending)}: ${balance.pendingPoints}',
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  '${context.tr(TranslationsKeys.expiring)}: ${balance.expiringPoints}',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

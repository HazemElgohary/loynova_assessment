import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/extentions/date_time.dart';
import '../../domain/entities/transaction_entity.dart';

class TransactionItem extends StatelessWidget {
  final TransactionEntity item;

  const TransactionItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: item.merchantLogo != null
            ? CachedNetworkImage(
                width: 40,
                height: 40,
                imageUrl: item.merchantLogo!,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.account_balance_wallet),
              )
            : const Icon(Icons.account_balance_wallet),
        title: Text(item.description),
        subtitle: Text(item.createdAt.toTimeFormat()),
        trailing: Column(
          mainAxisSize: .min,
          children: [
            Text(
              '${item.points > 0 ? '+' : ''}${item.points}',
              style: TextStyle(
                color: item.points > 0
                    ? const Color(0xFF00B894)
                    : const Color(0xFFE74C3C),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              item.status.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

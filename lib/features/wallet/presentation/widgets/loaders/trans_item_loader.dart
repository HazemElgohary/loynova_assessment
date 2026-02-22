import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TransItemLoader extends StatelessWidget {
  const TransItemLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.grey.shade100,
      child: Card(
        color: const Color(0xFF6C5CE7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: const SizedBox(height: 80),
      ),
    );
  }
}

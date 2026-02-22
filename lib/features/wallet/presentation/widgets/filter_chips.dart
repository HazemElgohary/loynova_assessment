import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/enums.dart';
import '../../../../core/utils/extentions/enums.dart';

class FilterChips extends StatelessWidget {
  final TransactionType? currentFilter;
  final ValueChanged<TransactionType?> onFilterSelected;

  const FilterChips({
    super.key,
    required this.currentFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    final filters = [null, ...TransactionType.values];

    return Wrap(
      spacing: 8,
      children: filters.map((filter) {
        final isSelected = currentFilter == filter;
        return ChoiceChip(
          label: Text(filter?.displayName ?? 'All'),
          selected: isSelected,
          onSelected: (_) => onFilterSelected(filter),
        );
      }).toList(),
    );
  }
}

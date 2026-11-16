import 'package:flutter/material.dart';
import 'package:task/core/theme/app_colors.dart';
import 'package:task/core/theme/app_spacing.dart';

class PropertyFilterBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onFilterChanged;

  static const filters = ['الكل', 'البيع', 'الإيجار'];

  const PropertyFilterBar({
    super.key,
    required this.selectedIndex,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenHorizontal, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(filters.length * 2 - 1, (i) {
          if (i.isOdd) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: Text('|', style: TextStyle(color: Color(0xFFD1D5DB), fontSize: 13)),
            );
          }
          final idx = i ~/ 2;
          final isSelected = selectedIndex == idx;
          return GestureDetector(
            onTap: () => onFilterChanged(idx),
            behavior: HitTestBehavior.opaque,
            child: Text(
              filters[idx],
              style: TextStyle(
                fontSize: 13,
                color: isSelected ? AppColors.textPrimary : const Color(0xFF6B7280),
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                fontFamily: 'Cairo',
              ),
            ),
          );
        }),
      ),
    );
  }
}

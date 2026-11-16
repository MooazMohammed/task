import 'package:flutter/material.dart';
import 'package:task/core/theme/app_colors.dart';
import 'package:task/core/theme/app_text_styles.dart';
import 'package:task/core/theme/app_spacing.dart';

/// Section Header with title, 'مشاهدة الكل', and filter tabs (الكل | للبيع | للإيجار)
class FeaturedSectionHeader extends StatelessWidget {
  final int selectedFilter;
  final ValueChanged<int> onFilterChanged;
  final VoidCallback onSeeAll;

  static const _filters = ['الكل', 'للبيع', 'للإيجار'];

  const FeaturedSectionHeader({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
    required this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
        vertical: 6,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'عقارات مميزة في مصر',
                style: AppTextStyles.sectionTitle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              GestureDetector(
                onTap: onSeeAll,
                child: Text(
                  'مشاهدة الكل',
                  style: AppTextStyles.seeAll.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(_filters.length * 2 - 1, (i) {
              if (i.isOdd) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    '|',
                    style: TextStyle(color: Color(0xFFD1D5DB), fontSize: 13),
                  ),
                );
              }
              final idx = i ~/ 2;
              final isSelected = selectedFilter == idx;
              return GestureDetector(
                onTap: () => onFilterChanged(idx),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    _filters[idx],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                      color: isSelected ? AppColors.primary : const Color(0xFF6B7280),
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

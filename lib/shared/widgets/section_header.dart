import 'package:flutter/material.dart';
import 'package:task/core/theme/app_colors.dart';
import 'package:task/core/theme/app_text_styles.dart';
import 'package:task/core/theme/app_spacing.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? seeAllText;
  final VoidCallback? onSeeAll;

  const SectionHeader({
    super.key,
    required this.title,
    this.seeAllText = 'مشاهدة الكل',
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenHorizontal, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyles.sectionTitle),
          if (seeAllText != null)
            GestureDetector(
              onTap: onSeeAll,
              child: SizedBox(
                height: AppSpacing.minTouchTarget,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(seeAllText!, style: AppTextStyles.seeAll),
                    // In RTL, chevron_left points toward "more"
                    const Icon(Icons.chevron_left,
                        size: 18, color: AppColors.primary),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

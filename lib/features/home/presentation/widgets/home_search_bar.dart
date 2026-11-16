import 'package:flutter/material.dart';
import 'package:task/core/theme/app_text_styles.dart';
import 'package:task/core/theme/app_spacing.dart';
import 'package:task/core/constants/app_strings.dart';

class HomeSearchBar extends StatelessWidget {
  final VoidCallback? onTap;

  const HomeSearchBar({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F6F8),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppStrings.searchHint, // 'كيف يمكننا مساعدتك'
                style: AppTextStyles.body2.copyWith(
                  color: const Color(0xFF9E9E9E),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.search_rounded,
                color: Color(0xFF9E9E9E),
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

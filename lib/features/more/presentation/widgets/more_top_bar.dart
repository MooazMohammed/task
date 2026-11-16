import 'package:flutter/material.dart';
import 'package:task/core/theme/app_colors.dart';
import 'package:task/core/theme/app_spacing.dart';
import 'package:task/core/constants/app_strings.dart';

class MoreTopBar extends StatelessWidget {
  const MoreTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
        vertical: 12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              final scaffold = Scaffold.maybeOf(context);
              if (scaffold != null && scaffold.isEndDrawerOpen) {
                scaffold.closeEndDrawer();
              } else if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            },
            behavior: HitTestBehavior.opaque,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppColors.textPrimary),
                SizedBox(width: 8),
                Text(
                  AppStrings.more,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('🇪🇬', style: TextStyle(fontSize: 20)),
                SizedBox(width: 4),
                Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: AppColors.textSecondary),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

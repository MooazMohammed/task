import 'package:flutter/material.dart';
import 'package:task/core/theme/app_colors.dart';
import 'package:task/core/theme/app_text_styles.dart';

class MenuItemTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final int? badge;
  final bool isDestructive;
  final VoidCallback? onTap;

  // Blue from home bottom navigation and Figma Frame 34343
  static const Color iconColor = AppColors.primary; // Color(0xFF0A2753)

  const MenuItemTile({
    super.key,
    required this.icon,
    required this.title,
    this.badge,
    this.isDestructive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? const Color(0xFFE53935) : iconColor;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: AppColors.primary.withAlpha(20),
        highlightColor: AppColors.primary.withAlpha(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: [
              // Icon on right in RTL (navy blue or red for logout)
              Icon(icon, size: 22, color: color),
              const SizedBox(width: 14),

              // Title
              Expanded(
                child: Text(
                  title,
                  style: isDestructive
                      ? AppTextStyles.menuItem.copyWith(
                          color: const Color(0xFFE53935),
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        )
                      : AppTextStyles.menuItem.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                ),
              ),

              // Notification / Chat count badge if present (on left in RTL)
              if (badge != null && badge! > 0)
                Container(
                  width: 18,
                  height: 18,
                  decoration: const BoxDecoration(
                    color: AppColors.badgeRed,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '$badge',
                      style: AppTextStyles.badge.copyWith(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

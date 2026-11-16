import 'package:flutter/material.dart';
import 'package:task/core/theme/app_colors.dart';
import 'package:task/core/theme/app_text_styles.dart';
import 'package:task/core/theme/app_spacing.dart';
import 'package:task/core/constants/app_assets.dart';
import '../home_search_bar.dart';
import 'header_action_icons.dart';
import 'location_dropdown.dart';

/// Top header card enclosing logo, location selector, action icons, and search bar
class HomeTopHeader extends StatelessWidget {
  final String selectedCity;
  final VoidCallback onOpenMore;
  final VoidCallback onLocationTap;
  final VoidCallback? onNotificationsTap;
  final VoidCallback? onChatTap;
  final VoidCallback? onSearchTap;

  const HomeTopHeader({
    super.key,
    required this.selectedCity,
    required this.onOpenMore,
    required this.onLocationTap,
    this.onNotificationsTap,
    this.onChatTap,
    this.onSearchTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x0F000000),
            offset: Offset(0, 4),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      child: Column(
        children: [
          _buildLogo(),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenHorizontal),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LocationDropdown(city: selectedCity, onTap: onLocationTap),
                HeaderActionIcons(
                  onOpenMore: onOpenMore,
                  onNotificationsTap: onNotificationsTap,
                  onChatTap: onChatTap,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          HomeSearchBar(onTap: onSearchTap),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Center(
      child: Image.asset(
        AppAssets.logoPng,
        height: 34,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => Text(
          'امتلاك',
          style: AppTextStyles.h2.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

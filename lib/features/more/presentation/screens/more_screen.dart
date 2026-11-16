import 'package:flutter/material.dart';
import 'package:task/core/theme/app_colors.dart';
import 'package:task/core/theme/app_spacing.dart';
import 'package:task/core/constants/app_strings.dart';
import '../widgets/menu_item_tile.dart';
import '../widgets/user_profile_header.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  static const _menuItems = [
    _MI(Icons.favorite_rounded, AppStrings.myFavorites),
    _MI(Icons.notifications_rounded, AppStrings.notifications, badge: 2),
    _MI(Icons.chat_bubble_rounded, AppStrings.chat, badge: 5),
    _MI(Icons.domain_add_rounded, AppStrings.addProperty),
    _MI(Icons.verified_rounded, AppStrings.buyPackages),
    _MI(Icons.business_rounded, AppStrings.latestProjectsMenu),
    _MI(Icons.help_rounded, AppStrings.helpCenter),
    _MI(Icons.support_agent_rounded, AppStrings.customerService),
    _MI(Icons.person_add_alt_1_rounded, AppStrings.joinUs),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const UserProfileHeader(),
                    const SizedBox(height: 6),

                    // Menu items list matching Figma Frame 34343
                    ..._menuItems.map(
                      (item) => MenuItemTile(
                        icon: item.icon,
                        title: item.title,
                        badge: item.badge,
                        onTap: () {},
                      ),
                    ),

                    // Logout item (Red)
                    MenuItemTile(
                      icon: Icons.logout_rounded,
                      title: AppStrings.logout,
                      isDestructive: true,
                      onTap: () => _confirmLogout(context),
                    ),

                    const SizedBox(height: AppSpacing.lg),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
        vertical: 12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Close / Back button with 'المزيد' (on right in RTL, matching Figma)
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
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: AppColors.textPrimary,
                ),
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

          // Country/language selector — on left in RTL
          GestureDetector(
            onTap: () {},
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('🇪🇬', style: TextStyle(fontSize: 20)),
                SizedBox(width: 4),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 18,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('تسجيل الخروج', textAlign: TextAlign.center),
        content: const Text(
          'هل أنت متأكد أنك تريد تسجيل الخروج؟',
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(foregroundColor: AppColors.primary),
            child: const Text('إلغاء'),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: Colors.white),
            child: const Text('تسجيل الخروج'),
          ),
        ],
      ),
    );
  }
}

class _MI {
  final IconData icon;
  final String title;
  final int? badge;
  const _MI(this.icon, this.title, {this.badge});
}

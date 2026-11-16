import 'package:flutter/material.dart';
import 'package:task/core/theme/app_colors.dart';
import 'package:task/core/theme/app_text_styles.dart';
import 'package:task/features/home/presentation/screens/home_screen.dart';
import 'package:task/features/more/presentation/screens/more_screen.dart';
import 'navigation/floating_nav_bar.dart';

/// Main navigation shell coordinating bottom navigation with IndexedStack
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  static const _screens = [
    HomeScreen(),
    MoreScreen(),
    _PlaceholderScreen('العروض', Icons.local_fire_department_rounded),
    _PlaceholderScreen('السوق', Icons.storefront_rounded),
    _PlaceholderScreen('المطورون', Icons.domain_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: FloatingNavBar(
        selectedIndex: _currentIndex,
        onTabSelected: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}

class _PlaceholderScreen extends StatelessWidget {
  final String title;
  final IconData icon;

  const _PlaceholderScreen(this.title, this.icon);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56, color: AppColors.textDisabled),
            const SizedBox(height: 12),
            Text(title, style: AppTextStyles.h2.copyWith(color: AppColors.textDisabled)),
          ],
        ),
      ),
    );
  }
}

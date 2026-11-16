import 'package:flutter/material.dart';
import 'package:task/core/theme/app_colors.dart';
import 'package:task/core/theme/app_text_styles.dart';
import 'package:task/features/home/presentation/screens/home_screen.dart';
import 'package:task/features/more/presentation/screens/more_screen.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Bottom Navigation — matches Figma exactly (RTL, right → left):
//
//  [ المطلوبون ]  [ السوق ]  ● الرئيسية ●  [ العروض ]  [ عقاراتي ]
//     idx=4          idx=3        idx=0        idx=2        idx=1
//
// Center FAB = Home (الرئيسية) — elevated circle with home+search icon
// Uses Scaffold.floatingActionButton + BottomAppBar(CircularNotchedRectangle)
// ─────────────────────────────────────────────────────────────────────────────

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _idx = 0; // Home is active on launch

  // ── Screens ──────────────────────────────────────────────────
  static const _screens = [
    HomeScreen(),                                              // 0 → FAB الرئيسية
    MoreScreen(),                                             // 1 → عقاراتي
    _Placeholder('العروض',      Icons.local_fire_department_rounded), // 2
    _Placeholder('السوق',       Icons.storefront_rounded),    // 3
    _Placeholder('المطلوبون',   Icons.people_rounded),        // 4
  ];

  // ── Side items — 2 on each side of Center Button ────────────
  // RTL Row renders right → left, so array[0] = FAR RIGHT of bar.
  //
  //  array[0]       array[1]    ●Center●    array[2]      array[3]
  //  المطورون       السوق       الرئيسية    العروض        عقاراتي
  //  idx=4          idx=3        idx=0      idx=2         idx=1
  static const _sideItems = [
    _NavItem(
      Icons.groups_outlined,
      Icons.groups_rounded,
      'المطورون',
      4,
    ),
    _NavItem(
      Icons.storefront_outlined,
      Icons.storefront_rounded,
      'السوق',
      3,
    ),
    _NavItem(
      Icons.local_fire_department_outlined,
      Icons.local_fire_department_rounded,
      'العروض',
      2,
    ),
    _NavItem(
      Icons.apartment_outlined,
      Icons.apartment_rounded,
      'عقاراتي',
      1,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: _idx, children: _screens),
      bottomNavigationBar: _buildFloatingBar(),
    );
  }

  // ── Floating Elevated Navigation Bar (Matches Figma Image 2) ──
  Widget _buildFloatingBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: Container(
          height: 66,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: const [
              BoxShadow(
                color: Color(0x26000000),
                blurRadius: 20,
                spreadRadius: 1,
                offset: Offset(0, 6),
              ),
              BoxShadow(
                color: Color(0x0F000000),
                blurRadius: 8,
                spreadRadius: 0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // RIGHT side (RTL): المطورون, السوق
              _buildTab(_sideItems[0]),
              _buildTab(_sideItems[1]),

              // CENTER: Floating circular navy button (الرئيسية)
              _buildCenterButton(),

              // LEFT side: العروض, عقاراتي
              _buildTab(_sideItems[2]),
              _buildTab(_sideItems[3]),
            ],
          ),
        ),
      ),
    );
  }

  // ── Center elevated button (الرئيسية) ─────────────────────────
  Widget _buildCenterButton() {
    final active = _idx == 0;
    return GestureDetector(
      onTap: () => setState(() => _idx = 0),
      child: Container(
        width: 54,
        height: 54,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: AppColors.primary, // Deep Navy Color(0xFF0A2753)
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0x550A2753),
              blurRadius: 12,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: _HomeSearchIcon(
            key: ValueKey(active),
            active: active,
          ),
        ),
      ),
    );
  }

  // ── Individual side tab ──────────────────────────────────────
  Widget _buildTab(_NavItem item) {
    final active = _idx == item.screenIdx;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => setState(() => _idx = item.screenIdx),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 180),
              child: Icon(
                active ? item.activeIcon : item.icon,
                key: ValueKey(active),
                size: 24,
                color: active ? AppColors.navActive : AppColors.navInactive,
              ),
            ),
            const SizedBox(height: 3),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 180),
              style: AppTextStyles.navLabel.copyWith(
                color: active ? AppColors.navActive : AppColors.navInactive,
                fontWeight:
                    active ? FontWeight.w700 : FontWeight.w400,
              ),
              child: Text(item.label),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Custom home+search icon for FAB ─────────────────────────────────────────
class _HomeSearchIcon extends StatelessWidget {
  final bool active;
  const _HomeSearchIcon({super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Icon(Icons.home_rounded, color: Colors.white, size: 28),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(50),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.search_rounded,
                color: Colors.white, size: 12),
          ),
        ),
      ],
    );
  }
}

// ─── Data model ───────────────────────────────────────────────────────────────
class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final int screenIdx;
  const _NavItem(this.icon, this.activeIcon, this.label, this.screenIdx);
}

// ─── Placeholder screens ──────────────────────────────────────────────────────
class _Placeholder extends StatelessWidget {
  final String label;
  final IconData icon;
  const _Placeholder(this.label, this.icon);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56, color: AppColors.textDisabled),
            const SizedBox(height: 12),
            Text(
              label,
              style: AppTextStyles.h2
                  .copyWith(color: AppColors.textDisabled),
            ),
          ],
        ),
      ),
    );
  }
}

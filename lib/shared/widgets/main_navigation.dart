import 'package:flutter/material.dart';
import 'package:task/core/theme/app_colors.dart';
import 'package:task/core/theme/app_text_styles.dart';
import 'package:task/features/home/presentation/screens/home_screen.dart';
import 'package:task/features/more/presentation/screens/more_screen.dart';

/// Bottom Navigation Bar — matches the exact Figma design in media_1794840903880_b7646b39.jpg:
/// - Floating rounded white card with soft drop shadow
/// - Center elevated circle (Home) with house + search icon
/// - Right to Left order (RTL):
///   [المطورون]  [السوق]  ●الرئيسية (FAB)●  [العروض]  [عقاراتي]
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _idx = 0; // Home is active on launch

  // ── Screens ──────────────────────────────────────────────────
  static const _screens = [
    HomeScreen(),                                                        // 0 → Home
    MoreScreen(),                                                       // 1 → عقاراتي
    _Placeholder('العروض', Icons.local_fire_department_rounded),       // 2
    _Placeholder('السوق', Icons.storefront_rounded),                   // 3
    _Placeholder('المطورون', Icons.domain_rounded),                     // 4
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: _idx, children: _screens),
      bottomNavigationBar: _buildFloatingBottomBar(),
    );
  }

  // ── Floating Navigation Bar matching Figma ────────────────────
  Widget _buildFloatingBottomBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: SizedBox(
          height: 72,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              // White rounded container
              Container(
                height: 66,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x18000000),
                      blurRadius: 18,
                      spreadRadius: 0,
                      offset: Offset(0, 4),
                    ),
                    BoxShadow(
                      color: Color(0x0A02658B),
                      blurRadius: 8,
                      spreadRadius: 0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // 1. المطورون (Far Right in RTL)
                    _buildTabItem(
                      label: 'المطورون',
                      screenIdx: 4,
                      iconBuilder: (active) => Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          Icon(
                            active
                                ? Icons.apartment_rounded
                                : Icons.apartment_outlined,
                            size: 23,
                            color: active
                                ? const Color(0xFF02658B)
                                : const Color(0xFF334155),
                          ),
                          Positioned(
                            right: -3,
                            bottom: -1,
                            child: Container(
                              padding: const EdgeInsets.all(0.5),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.person,
                                size: 11,
                                color: active
                                    ? const Color(0xFF02658B)
                                    : const Color(0xFF334155),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 2. السوق (Second from Right)
                    _buildTabItem(
                      label: 'السوق',
                      screenIdx: 3,
                      iconBuilder: (active) => Icon(
                        active
                            ? Icons.storefront_rounded
                            : Icons.storefront_outlined,
                        size: 24,
                        color: active
                            ? const Color(0xFF02658B)
                            : const Color(0xFF334155),
                      ),
                    ),

                    // Gap in center for the elevated home button
                    const SizedBox(width: 66),

                    // 3. العروض (Second from Left)
                    _buildTabItem(
                      label: 'العروض',
                      screenIdx: 2,
                      iconBuilder: (active) => Icon(
                        active
                            ? Icons.local_fire_department_rounded
                            : Icons.local_fire_department_outlined,
                        size: 24,
                        color: active
                            ? const Color(0xFF02658B)
                            : const Color(0xFF334155),
                      ),
                    ),

                    // 4. عقاراتي (Far Left in RTL)
                    _buildTabItem(
                      label: 'عقاراتي',
                      screenIdx: 1,
                      iconBuilder: (active) => Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          Icon(
                            active
                                ? Icons.apartment_rounded
                                : Icons.apartment_outlined,
                            size: 23,
                            color: active
                                ? const Color(0xFF02658B)
                                : const Color(0xFF334155),
                          ),
                          Positioned(
                            right: -3,
                            bottom: -1,
                            child: Container(
                              padding: const EdgeInsets.all(0.5),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.key_rounded,
                                size: 10,
                                color: active
                                    ? const Color(0xFF02658B)
                                    : const Color(0xFF334155),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Center elevated button (Home) floating on top
              Positioned(
                top: -6,
                child: _buildCenterHomeButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Center floating home button ──────────────────────────────
  Widget _buildCenterHomeButton() {
    return GestureDetector(
      onTap: () => setState(() => _idx = 0),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: const Color(0xFF02658B), // Deep teal matching Figma
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 3.5,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x3B02658B),
              blurRadius: 14,
              spreadRadius: 1,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: const [
              Icon(
                Icons.home_rounded,
                color: Colors.white,
                size: 32,
              ),
              Positioned(
                bottom: 7,
                child: Icon(
                  Icons.search_rounded,
                  color: Color(0xFF02658B),
                  size: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Tab item builder ─────────────────────────────────────────
  Widget _buildTabItem({
    required String label,
    required int screenIdx,
    required Widget Function(bool active) iconBuilder,
  }) {
    final active = _idx == screenIdx;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => setState(() => _idx = screenIdx),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconBuilder(active),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 11.5,
                fontWeight: active ? FontWeight.w800 : FontWeight.w600,
                color: active
                    ? const Color(0xFF02658B)
                    : const Color(0xFF334155),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Placeholder screen ─────────────────────────────────────────────────────
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
              style: AppTextStyles.h2.copyWith(color: AppColors.textDisabled),
            ),
          ],
        ),
      ),
    );
  }
}

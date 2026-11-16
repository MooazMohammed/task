import 'package:flutter/material.dart';
import 'nav_tab_item.dart';
import 'nav_center_button.dart';

/// Floating bottom navigation bar component matching Figma design
class FloatingNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const FloatingNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: SizedBox(
          height: 72,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              _buildBackgroundCard(),
              Positioned(
                top: -6,
                child: NavCenterButton(onTap: () => onTabSelected(0)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackgroundCard() {
    return Container(
      height: 66,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: Color(0x18000000),
            blurRadius: 18,
            offset: Offset(0, 4),
          ),
          BoxShadow(
            color: Color(0x0A02658B),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          NavTabItem(
            label: 'المطورون',
            screenIdx: 4,
            active: selectedIndex == 4,
            icon: _developerIcon(selectedIndex == 4),
            onTap: onTabSelected,
          ),
          NavTabItem(
            label: 'السوق',
            screenIdx: 3,
            active: selectedIndex == 3,
            icon: Icon(
              selectedIndex == 3 ? Icons.storefront_rounded : Icons.storefront_outlined,
              size: 24,
              color: selectedIndex == 3 ? const Color(0xFF02658B) : const Color(0xFF334155),
            ),
            onTap: onTabSelected,
          ),
          const SizedBox(width: 66),
          NavTabItem(
            label: 'العروض',
            screenIdx: 2,
            active: selectedIndex == 2,
            icon: Icon(
              selectedIndex == 2 ? Icons.local_fire_department_rounded : Icons.local_fire_department_outlined,
              size: 24,
              color: selectedIndex == 2 ? const Color(0xFF02658B) : const Color(0xFF334155),
            ),
            onTap: onTabSelected,
          ),
          NavTabItem(
            label: 'عقاراتي',
            screenIdx: 1,
            active: selectedIndex == 1,
            icon: _myPropertiesIcon(selectedIndex == 1),
            onTap: onTabSelected,
          ),
        ],
      ),
    );
  }

  Widget _developerIcon(bool active) {
    final color = active ? const Color(0xFF02658B) : const Color(0xFF334155);
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Icon(
          active ? Icons.apartment_rounded : Icons.apartment_outlined,
          size: 23,
          color: color,
        ),
        Positioned(
          right: -3,
          bottom: -1,
          child: Container(
            padding: const EdgeInsets.all(0.5),
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: Icon(Icons.person, size: 11, color: color),
          ),
        ),
      ],
    );
  }

  Widget _myPropertiesIcon(bool active) {
    final color = active ? const Color(0xFF02658B) : const Color(0xFF334155);
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Icon(
          active ? Icons.apartment_rounded : Icons.apartment_outlined,
          size: 23,
          color: color,
        ),
        Positioned(
          right: -3,
          bottom: -1,
          child: Container(
            padding: const EdgeInsets.all(0.5),
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: Icon(Icons.key_rounded, size: 10, color: color),
          ),
        ),
      ],
    );
  }
}

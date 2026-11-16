import 'package:flutter/material.dart';
import 'package:task/core/theme/app_colors.dart';

class MoreMenuButton extends StatelessWidget {
  final VoidCallback onTap;
  const MoreMenuButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 38,
        height: 38,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _line(),
              const SizedBox(height: 4.5),
              _line(),
              const SizedBox(height: 4.5),
              _line(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _line() => Container(
        width: 22,
        height: 2.5,
        decoration: BoxDecoration(
          color: AppColors.textPrimary,
          borderRadius: BorderRadius.circular(2),
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:task/core/theme/app_colors.dart';

class ChatActionButton extends StatelessWidget {
  final int badge;
  final VoidCallback? onTap;

  const ChatActionButton({super.key, required this.badge, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 38,
        height: 38,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            const Icon(Icons.chat_bubble_outline_rounded, size: 26, color: AppColors.textPrimary),
            if (badge > 0)
              Positioned(
                bottom: 2,
                right: 2,
                child: Container(
                  padding: const EdgeInsets.all(1.5),
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: const BoxDecoration(color: AppColors.badgeRed, shape: BoxShape.circle),
                    child: Center(
                      child: Text(
                        '$badge',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          height: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

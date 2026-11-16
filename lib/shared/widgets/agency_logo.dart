import 'package:flutter/material.dart';
import 'package:task/core/theme/app_colors.dart';
import 'package:task/core/theme/app_text_styles.dart';

/// Clean reusable Agency Logo badge (بواسطة + GS + GOLD SQUARE)
class AgencyLogo extends StatelessWidget {
  const AgencyLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'بواسطة',
          style: AppTextStyles.caption.copyWith(
            fontSize: 8.5,
            color: AppColors.textDisabled,
          ),
        ),
        const SizedBox(height: 2),
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFE53935), width: 1.2),
            boxShadow: const [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 3,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              'GS',
              style: TextStyle(
                color: Color(0xFFE53935),
                fontWeight: FontWeight.w900,
                fontSize: 9,
                letterSpacing: -0.5,
              ),
            ),
          ),
        ),
        const SizedBox(height: 1),
        const Text(
          'GOLD SQUARE',
          style: TextStyle(
            color: Color(0xFFE53935),
            fontSize: 5.5,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
        ),
      ],
    );
  }
}

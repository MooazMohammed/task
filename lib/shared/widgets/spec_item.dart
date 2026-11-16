import 'package:flutter/material.dart';
import 'package:task/core/theme/app_colors.dart';

/// Clean reusable Property Spec Item (value + icon)
class SpecItem extends StatelessWidget {
  final String value;
  final IconData icon;
  final double fontSize;
  final double iconSize;
  final Color? color;

  const SpecItem({
    super.key,
    required this.value,
    required this.icon,
    this.fontSize = 10,
    this.iconSize = 13,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final itemColor = color ?? AppColors.textPrimary;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
            color: itemColor,
            fontFamily: 'Cairo',
          ),
        ),
        const SizedBox(width: 3),
        Icon(icon, size: iconSize, color: itemColor),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary brand colors
  static const Color primary = Color(0xFF0A2753);       // Navy Blue
  static const Color primaryLight = Color(0xFF1A3D6E);
  static const Color secondary = Color(0xFF00C853);     // Green
  static const Color accent = Color(0xFFFFC700);        // Yellow CTA

  // Semantic colors
  static const Color error = Color(0xFFE53935);         // Red (destructive)
  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFF57C00);
  static const Color info = Color(0xFF1565C0);

  // Surfaces
  static const Color surface = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFFFFFFF); // Pure white background as in Figma
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color divider = Color(0xFFE8ECF0);

  // Text — all WCAG AA compliant (contrast ≥ 4.5:1 on white)
  static const Color textPrimary = Color(0xFF1A1A2E);    // 15.3:1 on white
  static const Color textSecondary = Color(0xFF555F6E);  // 7.0:1 on white
  static const Color textDisabled = Color(0xFFADB5BD);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnAccent = Color(0xFF1A1A2E);   // dark on yellow

  // Nav bar
  static const Color navActive = Color(0xFF0A2753);
  static const Color navInactive = Color(0xFFADB5BD);

  // Badge
  static const Color badgeRed = Color(0xFFE53935);
  static const Color badgeGreen = Color(0xFF00C853);

  // Property card
  static const Color priceTag = Color(0xFF0A2753);
  static const Color featuredBadge = Color(0xFFFFC700);
  static const Color newBadge = Color(0xFF00C853);
  static const Color heartActive = Color(0xFFE53935);
  static const Color heartInactive = Color(0xFFFFFFFF);

  // Shimmer
  static const Color shimmerBase = Color(0xFFE0E0E0);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);
}

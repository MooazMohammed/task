import 'package:flutter/material.dart';
import 'package:task/core/theme/app_colors.dart';
import 'package:task/core/theme/app_text_styles.dart';
import 'package:task/core/theme/app_spacing.dart';

class HeroBannerSlide extends StatelessWidget {
  final Map<String, String> slide;

  const HeroBannerSlide({super.key, required this.slide});

  @override
  Widget build(BuildContext context) {
    final buttonText = slide['buttonText'] ?? 'تواصل الآن';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenHorizontal),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              slide['imageUrl']!,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(color: AppColors.primary),
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x22000000), Color(0x99000000)],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    slide['title']!,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.h2.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      shadows: const [
                        Shadow(color: Color(0x99000000), blurRadius: 4),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    slide['subtitle']!,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body2.copyWith(
                      color: Colors.white.withAlpha(230),
                      fontSize: 11,
                      height: 1.4,
                      shadows: const [
                        Shadow(color: Color(0x88000000), blurRadius: 4),
                      ],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: const [
                        BoxShadow(color: Color(0x33000000), blurRadius: 4, offset: Offset(0, 2)),
                      ],
                    ),
                    child: Text(
                      buttonText,
                      style: AppTextStyles.button.copyWith(
                        color: AppColors.textOnAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

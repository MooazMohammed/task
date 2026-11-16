import 'package:flutter/material.dart';
import 'package:task/core/theme/app_colors.dart';
import 'package:task/core/theme/app_text_styles.dart';
import 'package:task/core/theme/app_spacing.dart';

class HeroBanner extends StatefulWidget {
  final List<Map<String, String>> slides;
  const HeroBanner({super.key, required this.slides});

  @override
  State<HeroBanner> createState() => _HeroBannerState();
}

class _HeroBannerState extends State<HeroBanner> {
  late final PageController _controller;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goToNext() {
    if (_currentPage < widget.slides.length - 1) {
      _controller.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToPrevious() {
    if (_currentPage > 0) {
      _controller.animateToPage(
        _currentPage - 1,
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final canGoLeft = _currentPage < widget.slides.length - 1;
    final canGoRight = _currentPage > 0;

    return Column(
      children: [
        SizedBox(
          height: 200,
          child: Stack(
            alignment: Alignment.center,
            children: [
              PageView.builder(
                controller: _controller,
                reverse: true, // RTL: right→left swipe
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemCount: widget.slides.length,
                itemBuilder: (_, index) => _buildSlide(widget.slides[index]),
              ),

              // ── Left arrow (points LEFT '<', advances to next slide on left) ──
              Positioned(
                left: AppSpacing.screenHorizontal + 8,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: canGoLeft ? 1.0 : 0.0,
                  child: IgnorePointer(
                    ignoring: !canGoLeft,
                    child: _buildArrowButton(
                      icon: Icons.chevron_left_rounded,
                      onTap: _goToNext,
                    ),
                  ),
                ),
              ),

              // ── Right arrow (points RIGHT '>', returns to previous slide on right) ──
              Positioned(
                right: AppSpacing.screenHorizontal + 8,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: canGoRight ? 1.0 : 0.0,
                  child: IgnorePointer(
                    ignoring: !canGoRight,
                    child: _buildArrowButton(
                      icon: Icons.chevron_right_rounded,
                      onTap: _goToPrevious,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // ── Custom RTL Dots Indicator ───────────────────────────────────
        // In RTL, index 0 is at the FAR RIGHT, matching slide 0 on the right.
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.slides.length, (i) {
            final active = i == _currentPage;
            return GestureDetector(
              onTap: () {
                _controller.animateToPage(
                  i,
                  duration: const Duration(milliseconds: 320),
                  curve: Curves.easeInOut,
                );
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: active ? 22 : 7,
                height: 7,
                decoration: BoxDecoration(
                  color: active ? AppColors.primary : AppColors.divider,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildArrowButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.black.withAlpha(120),
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
            size: 22,
            textDirection: TextDirection.ltr, // Preserve exact arrow pointing direction
          ),
        ),
      ),
    );
  }

  Widget _buildSlide(Map<String, String> slide) {
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
              errorBuilder: (_, __, ___) =>
                  Container(color: AppColors.primary),
            ),

            // Dark gradient overlay for text readability
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x22000000),
                    Color(0x99000000),
                  ],
                ),
              ),
            ),

            // Content in center (matching Figma exactly)
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
                  // Yellow CTA button "تواصل الآن"
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.accent, // Yellow #FFC700
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x33000000),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
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

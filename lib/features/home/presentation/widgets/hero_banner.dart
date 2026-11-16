import 'package:flutter/material.dart';
import 'package:task/core/theme/app_colors.dart';
import 'package:task/core/theme/app_spacing.dart';
import 'hero_banner_slide.dart';

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

  void _goTo(int page) {
    _controller.animateToPage(
      page,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeInOut,
    );
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
                reverse: true,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemCount: widget.slides.length,
                itemBuilder: (_, index) => HeroBannerSlide(slide: widget.slides[index]),
              ),
              Positioned(
                left: AppSpacing.screenHorizontal + 8,
                child: _arrowBtn(
                  icon: Icons.chevron_left_rounded,
                  visible: canGoLeft,
                  onTap: () => _goTo(_currentPage + 1),
                ),
              ),
              Positioned(
                right: AppSpacing.screenHorizontal + 8,
                child: _arrowBtn(
                  icon: Icons.chevron_right_rounded,
                  visible: canGoRight,
                  onTap: () => _goTo(_currentPage - 1),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.slides.length, (i) {
            final active = i == _currentPage;
            return GestureDetector(
              onTap: () => _goTo(i),
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

  Widget _arrowBtn({required IconData icon, required bool visible, required VoidCallback onTap}) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: visible ? 1.0 : 0.0,
      child: IgnorePointer(
        ignoring: !visible,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(120),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 22, textDirection: TextDirection.ltr),
          ),
        ),
      ),
    );
  }
}

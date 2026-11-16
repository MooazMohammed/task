import 'package:flutter/material.dart';
import 'package:task/core/theme/app_colors.dart';
import 'package:task/core/theme/app_text_styles.dart';
import 'package:task/core/theme/app_spacing.dart';
import 'package:task/core/constants/app_models.dart';
import 'package:task/shared/widgets/section_header.dart';
import 'property_list_card.dart';

/// Full property section: title + filter tabs + horizontal PageView of
/// [PropertyListCard]s + smooth page-indicator dots.
/// Matches the Figma design for أحدث الشقق / الفيلات / الدوبلكس / الشاليهات.
class PropertySection extends StatefulWidget {
  final String title;
  final List<PropertyModel> items;

  const PropertySection({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  State<PropertySection> createState() => _PropertySectionState();
}

class _PropertySectionState extends State<PropertySection> {
  int _filterIdx = 0;
  int _currentPage = 0;
  late final PageController _ctrl;

  static const _filters = ['الكل', 'البيع', 'الإيجار'];

  @override
  void initState() {
    super.initState();
    _ctrl = PageController();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Section header ──────────────────────────────────────
        SectionHeader(title: widget.title, onSeeAll: () {}),

        // ── Filter tabs (الكل | البيع | الإيجار) ───────────────
        _buildFilterRow(),

        // ── PageView of full-width cards ────────────────────────
        SizedBox(
          height: 162,
          child: PageView.builder(
            controller: _ctrl,
            reverse: true, // RTL: swipe right→left
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemCount: widget.items.length,
            itemBuilder: (_, i) => Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenHorizontal),
              child: PropertyListCard(
                property: widget.items[i],
                onTap: () {},
              ),
            ),
          ),
        ),

        // ── Page indicator dots (RTL-aware) ───────────────────────
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.items.length, (i) {
            final active = i == _currentPage;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 2.5),
              width: active ? 16 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: active ? AppColors.primary : AppColors.divider,
                borderRadius: BorderRadius.circular(3),
              ),
            );
          }),
        ),
        const SizedBox(height: 4),
      ],
    );
  }

  // ── Filter tab bar ────────────────────────────────────────────
  Widget _buildFilterRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenHorizontal, vertical: 4),
      child: Row(
        // RTL: mainAxisAlignment.end pushes to the right side
        mainAxisAlignment: MainAxisAlignment.end,
        children: List.generate(_filters.length * 2 - 1, (i) {
          if (i.isOdd) {
            // Divider between tabs
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text('|',
                  style: AppTextStyles.caption
                      .copyWith(color: AppColors.textDisabled)),
            );
          }
          final idx = i ~/ 2;
          final selected = _filterIdx == idx;
          return GestureDetector(
            onTap: () => setState(() => _filterIdx = idx),
            child: Text(
              _filters[idx],
              style: AppTextStyles.caption.copyWith(
                color: selected ? AppColors.primary : AppColors.textSecondary,
                fontWeight:
                    selected ? FontWeight.w700 : FontWeight.w400,
              ),
            ),
          );
        }),
      ),
    );
  }
}

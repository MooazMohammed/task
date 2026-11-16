import 'package:flutter/material.dart';
import 'package:task/core/theme/app_spacing.dart';
import 'package:task/core/constants/app_models.dart';
import 'package:task/shared/widgets/section_header.dart';
import 'property_list_card.dart';
import 'properties/property_filter_bar.dart';

/// Full property section: title + filter tabs + horizontal PageView + dots
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
        SectionHeader(title: widget.title, onSeeAll: () {}),
        PropertyFilterBar(
          selectedIndex: _filterIdx,
          onFilterChanged: (idx) => setState(() => _filterIdx = idx),
        ),
        SizedBox(
          height: 172,
          child: PageView.builder(
            controller: _ctrl,
            reverse: true,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemCount: widget.items.length,
            itemBuilder: (_, i) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenHorizontal),
              child: PropertyListCard(property: widget.items[i], onTap: () {}),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.items.length, (i) {
            final active = i == _currentPage;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                color: active ? const Color(0xFF02658B) : const Color(0xFFD1D5DB),
                shape: BoxShape.circle,
              ),
            );
          }),
        ),
        const SizedBox(height: 4),
      ],
    );
  }
}

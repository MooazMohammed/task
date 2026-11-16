import 'package:flutter/material.dart';
import 'package:task/core/theme/app_spacing.dart';
import 'package:task/core/constants/app_models.dart';
import 'package:task/shared/widgets/property_card.dart';

/// Horizontal scrolling list of featured property cards
class FeaturedPropertiesList extends StatelessWidget {
  final List<PropertyModel> items;
  final ValueChanged<PropertyModel>? onItemTap;

  const FeaturedPropertiesList({
    super.key,
    required this.items,
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 288,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenHorizontal,
          vertical: AppSpacing.sm,
        ),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.itemSpacing),
        itemBuilder: (_, i) => PropertyCard(
          property: items[i],
          width: 215,
          onTap: () => onItemTap?.call(items[i]),
        ),
      ),
    );
  }
}

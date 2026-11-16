import 'package:flutter/material.dart';
import 'package:task/core/theme/app_spacing.dart';
import 'package:task/core/constants/app_models.dart';
import '../city_card.dart';

/// Horizontal scrolling list of city cards
class CitiesHorizontalList extends StatelessWidget {
  final List<CityModel> cities;
  final ValueChanged<CityModel>? onCityTap;

  const CitiesHorizontalList({
    super.key,
    required this.cities,
    this.onCityTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 215,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenHorizontal,
          vertical: AppSpacing.sm,
        ),
        itemCount: cities.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.itemSpacing),
        itemBuilder: (_, i) => CityCard(
          city: cities[i],
          onTap: () => onCityTap?.call(cities[i]),
        ),
      ),
    );
  }
}

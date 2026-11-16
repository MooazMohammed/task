import 'package:flutter/material.dart';
import 'package:task/core/theme/app_colors.dart';
import 'package:task/core/theme/app_text_styles.dart';

/// Bottom sheet dialog for choosing the active city
class CityPickerSheet extends StatelessWidget {
  final String selectedCity;
  final ValueChanged<String> onCitySelected;

  static const List<String> availableCities = [
    'القاهرة',
    'الجيزة',
    'الإسكندرية',
    'الشيخ زايد',
    'التجمع الخامس',
    'الساحل الشمالي',
  ];

  const CityPickerSheet({
    super.key,
    required this.selectedCity,
    required this.onCitySelected,
  });

  static void show(BuildContext context, {required String currentCity, required ValueChanged<String> onSelected}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => CityPickerSheet(selectedCity: currentCity, onCitySelected: onSelected),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                'اختر المدينة',
                style: AppTextStyles.h3.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const Divider(),
            ...availableCities.map(
              (city) => ListTile(
                title: Text(
                  city,
                  style: AppTextStyles.body1.copyWith(
                    fontWeight: selectedCity == city ? FontWeight.bold : FontWeight.normal,
                    color: selectedCity == city ? AppColors.primary : AppColors.textPrimary,
                  ),
                ),
                trailing: selectedCity == city
                    ? const Icon(Icons.check_circle_rounded, color: AppColors.primary)
                    : null,
                onTap: () {
                  onCitySelected(city);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

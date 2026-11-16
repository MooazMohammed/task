import '../constants/app_models.dart';
import '../constants/app_assets.dart';

class MockCities {
  MockCities._();

  static final List<CityModel> cities = [
    CityModel(
      name: 'القاهرة',
      imageUrl: AppAssets.city1,
      propertyCount: 1507,
      forSaleCount: 505,
      forRentCount: 1002,
    ),
    CityModel(
      name: 'الجيزة',
      imageUrl: AppAssets.city2,
      propertyCount: 1507,
      forSaleCount: 505,
      forRentCount: 1002,
    ),
    CityModel(
      name: 'الإسكندرية',
      imageUrl: AppAssets.city3,
      propertyCount: 870,
      forSaleCount: 320,
      forRentCount: 550,
    ),
    CityModel(
      name: 'القاهرة الجديدة',
      imageUrl: AppAssets.city4,
      propertyCount: 620,
      forSaleCount: 240,
      forRentCount: 380,
    ),
  ];
}

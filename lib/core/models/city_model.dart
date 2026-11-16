class CityModel {
  final String name;
  final String imageUrl;
  final int propertyCount;
  final int forSaleCount;
  final int forRentCount;

  const CityModel({
    required this.name,
    required this.imageUrl,
    required this.propertyCount,
    this.forSaleCount = 505,
    this.forRentCount = 1002,
  });
}

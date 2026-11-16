class PropertyModel {
  final String id;
  final String title;
  final String location;
  final double price;
  final int bedrooms;
  final int bathrooms;
  final double area;
  final String imageUrl;
  final bool isFeatured;
  final bool isNew;
  final bool isFavorite;
  final String type;
  final String transactionType;
  final String agentName;
  final int daysAgo;

  const PropertyModel({
    required this.id,
    required this.title,
    required this.location,
    required this.price,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    required this.imageUrl,
    this.isFeatured = false,
    this.isNew = false,
    this.isFavorite = false,
    required this.type,
    this.transactionType = 'للبيع',
    this.agentName = 'وكالة',
    this.daysAgo = 3,
  });

  String get formattedPrice {
    if (price >= 1000000) {
      return '${(price / 1000000).toStringAsFixed(1)} مليون ج.م';
    } else if (price >= 1000) {
      return '${(price / 1000).toStringAsFixed(0)} ألف ج.م';
    }
    return '${price.toStringAsFixed(0)} ج.م';
  }

  String get rawPrice {
    final formatted = price.toInt().toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
    if (transactionType == 'للإيجار') {
      return '$formatted ج.م شهريا';
    }
    return '$formatted ج.م';
  }
}

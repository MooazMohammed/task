// Property model
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
  final String type;           // شقة، فيلا، شاليه، دوبلكس
  final String transactionType; // للبيع، للإيجار
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

  // Raw price as number for display: "4,000,000 ج.م" or "4,000 ج.م شهريا"
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

// News model
class NewsModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String date;

  const NewsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.date,
  });
}

// City model
class CityModel {
  final String name;
  final String imageUrl;
  final int propertyCount;

  const CityModel({
    required this.name,
    required this.imageUrl,
    required this.propertyCount,
  });
}

// Project model
class ProjectModel {
  final String id;
  final String name;
  final String developer;
  final String location;
  final String imageUrl;
  final double discountPercent;

  const ProjectModel({
    required this.id,
    required this.name,
    required this.developer,
    required this.location,
    required this.imageUrl,
    this.discountPercent = 0,
  });
}

// Menu item model
class MenuItemModel {
  final String title;
  final String iconPath;
  final int? badgeCount;
  final bool isDestructive;
  final bool useIconData;

  const MenuItemModel({
    required this.title,
    required this.iconPath,
    this.badgeCount,
    this.isDestructive = false,
    this.useIconData = false,
  });
}

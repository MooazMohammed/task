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

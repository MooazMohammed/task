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

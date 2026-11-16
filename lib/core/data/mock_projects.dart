import '../constants/app_models.dart';
import '../constants/app_assets.dart';

class MockProjects {
  MockProjects._();

  static final List<ProjectModel> topProjects = [
    ProjectModel(
      id: 'p1',
      name: 'كمبوند الشيخ زايد',
      developer: 'تطوير مصر',
      location: 'الشيخ زايد، الجيزة',
      imageUrl: AppAssets.img2,
      discountPercent: 25,
    ),
    ProjectModel(
      id: 'p2',
      name: 'ميفيدا',
      developer: 'إعمار مصر',
      location: 'التجمع الخامس',
      imageUrl: AppAssets.img1,
      discountPercent: 15,
    ),
    ProjectModel(
      id: 'p3',
      name: 'الرحاب',
      developer: 'مدينة نصر للإسكان',
      location: 'القاهرة الجديدة',
      imageUrl: AppAssets.img5,
    ),
  ];
}

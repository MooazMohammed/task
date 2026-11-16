import 'app_models.dart';
import '../data/mock_properties.dart';
import '../data/mock_projects.dart';
import '../data/mock_cities.dart';
import '../data/mock_banners.dart';
import '../data/mock_news.dart';

class AppData {
  AppData._();

  static List<PropertyModel> get featuredProperties => MockProperties.featuredProperties;
  static List<ProjectModel> get topProjects => MockProjects.topProjects;
  static List<CityModel> get cities => MockCities.cities;
  static List<PropertyModel> get latestApartments => MockProperties.latestApartments;
  static List<PropertyModel> get latestVillas => MockProperties.latestVillas;
  static List<PropertyModel> get latestDuplexes => MockProperties.latestDuplexes;
  static List<PropertyModel> get latestChalets => MockProperties.latestChalets;
  static List<Map<String, String>> get bannerSlides => MockBanners.bannerSlides;
  static List<Map<String, String>> get officeBannerSlides => MockBanners.officeBannerSlides;
  static List<NewsModel> get latestNews => MockNews.latestNews;
}

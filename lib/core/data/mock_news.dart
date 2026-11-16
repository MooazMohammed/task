import '../constants/app_models.dart';
import '../constants/app_assets.dart';

class MockNews {
  MockNews._();

  static final List<NewsModel> latestNews = [
    NewsModel(
      id: 'n1',
      title: 'أحدث سوق إيجي',
      description:
          'هذا النص هو مثال لنص يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربي.',
      imageUrl: AppAssets.news1,
      date: 'منذ يومين',
    ),
    NewsModel(
      id: 'n2',
      title: 'أحدث سوق إيجي',
      description:
          'هذا النص هو مثال لنص يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربي.',
      imageUrl: AppAssets.news2,
      date: 'منذ 3 أيام',
    ),
  ];
}

import 'package:flutter/material.dart';
import 'package:task/core/theme/app_colors.dart';
import 'package:task/core/theme/app_spacing.dart';
import 'package:task/core/constants/app_data.dart';
import 'package:task/core/constants/app_models.dart';
import 'package:task/core/constants/app_strings.dart';
import 'package:task/features/more/presentation/screens/more_screen.dart';
import 'package:task/shared/widgets/section_header.dart';
import '../widgets/header/home_top_header.dart';
import '../widgets/header/city_picker_sheet.dart';
import '../widgets/featured/featured_section_header.dart';
import '../widgets/featured/featured_properties_list.dart';
import '../widgets/projects/top_projects_list.dart';
import '../widgets/cities/cities_horizontal_list.dart';
import '../widgets/hero_banner.dart';
import '../widgets/property_section.dart';
import '../widgets/news_section.dart';

/// Main home screen composing all real estate discovery sections
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _featuredFilter = 0; // 0: الكل, 1: للبيع, 2: للإيجار
  String _selectedCity = 'القاهرة';

  void _openMore() => _scaffoldKey.currentState?.openEndDrawer();

  void _showCityPicker() {
    CityPickerSheet.show(
      context,
      currentCity: _selectedCity,
      onSelected: (city) => setState(() => _selectedCity = city),
    );
  }

  void _showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text, textAlign: TextAlign.right), duration: const Duration(seconds: 2)),
    );
  }

  List<PropertyModel> get _filteredFeaturedProperties {
    if (_featuredFilter == 1) {
      return AppData.featuredProperties.where((p) => p.transactionType == 'للبيع').toList();
    } else if (_featuredFilter == 2) {
      return AppData.featuredProperties.where((p) => p.transactionType == 'للإيجار').toList();
    }
    return AppData.featuredProperties;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      endDrawer: const Drawer(
        width: 320,
        elevation: 16,
        child: MoreScreen(),
      ),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Top App Bar: Logo, Location, 3 Action Icons, Search Bar
            SliverToBoxAdapter(
              child: HomeTopHeader(
                selectedCity: _selectedCity,
                onOpenMore: _openMore,
                onLocationTap: _showCityPicker,
                onNotificationsTap: () => _showSnackBar('لديك إشعاران جديدان'),
                onChatTap: () => _showSnackBar('لديك 5 رسائل جديدة'),
              ),
            ),

            // Top Hero Banner
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                child: HeroBanner(slides: AppData.bannerSlides),
              ),
            ),

            // Featured Properties with filter tabs
            SliverToBoxAdapter(
              child: FeaturedSectionHeader(
                selectedFilter: _featuredFilter,
                onFilterChanged: (idx) => setState(() => _featuredFilter = idx),
                onSeeAll: () {},
              ),
            ),
            SliverToBoxAdapter(
              child: FeaturedPropertiesList(items: _filteredFeaturedProperties),
            ),

            // Top Real Estate Projects
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: AppSpacing.sectionSpacing),
                child: SectionHeader(title: 'اهم المشاريع العقارية في مصر', onSeeAll: () {}),
              ),
            ),
            SliverToBoxAdapter(
              child: TopProjectsList(projects: AppData.topProjects),
            ),

            // Search by City
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: AppSpacing.sectionSpacing),
                child: SectionHeader(title: AppStrings.searchByCity, onSeeAll: () {}),
              ),
            ),
            SliverToBoxAdapter(
              child: CitiesHorizontalList(cities: AppData.cities),
            ),

            // Commercial / Office Banner under Cities
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: AppSpacing.sectionSpacing, bottom: AppSpacing.xs),
                child: HeroBanner(slides: AppData.officeBannerSlides),
              ),
            ),

            // Latest Apartments
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: AppSpacing.sectionSpacing),
                child: PropertySection(title: AppStrings.latestApartments, items: AppData.latestApartments),
              ),
            ),

            // Latest Villas
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: AppSpacing.sectionSpacing),
                child: PropertySection(title: AppStrings.latestVillas, items: AppData.latestVillas),
              ),
            ),

            // Latest Duplexes
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: AppSpacing.sectionSpacing),
                child: PropertySection(title: 'أحدث الدوبلكس في مصر', items: AppData.latestDuplexes),
              ),
            ),

            // Latest Chalets
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: AppSpacing.sectionSpacing),
                child: PropertySection(title: 'أحدث الشاليهات في مصر', items: AppData.latestChalets),
              ),
            ),

            // Latest Real Estate News
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: AppSpacing.sectionSpacing),
                child: NewsSection(items: AppData.latestNews),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xl)),
          ],
        ),
      ),
    );
  }
}

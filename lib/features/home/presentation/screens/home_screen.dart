import 'package:flutter/material.dart';
import 'package:task/core/theme/app_colors.dart';
import 'package:task/core/theme/app_text_styles.dart';
import 'package:task/core/theme/app_spacing.dart';
import 'package:task/core/constants/app_data.dart';
import 'package:task/core/constants/app_assets.dart';
import 'package:task/core/constants/app_strings.dart';
import 'package:task/features/more/presentation/screens/more_screen.dart';
import 'package:task/shared/widgets/section_header.dart';
import 'package:task/shared/widgets/property_card.dart';
import '../widgets/hero_banner.dart';
import '../widgets/home_search_bar.dart';
import '../widgets/city_card.dart';
import '../widgets/project_card.dart';
import '../widgets/property_section.dart';
import '../widgets/news_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _featuredFilter = 0; // 0: الكل, 1: للبيع, 2: للإيجار

  void _openMore() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  List get _filteredFeaturedProperties {
    if (_featuredFilter == 1) {
      return AppData.featuredProperties
          .where((p) => p.transactionType == 'للبيع')
          .toList();
    } else if (_featuredFilter == 2) {
      return AppData.featuredProperties
          .where((p) => p.transactionType == 'للإيجار')
          .toList();
    }
    return AppData.featuredProperties;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      // Side drawer over home screen
      endDrawer: const Drawer(
        width: 320,
        elevation: 16,
        child: MoreScreen(),
      ),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // ── App Bar: Logo, Notification Bell, 'المزيد' Button & Search Bar ──
            SliverToBoxAdapter(
              child: _buildTopHeader(),
            ),

            // ── Hero Banner ────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: AppSpacing.sm, bottom: AppSpacing.sm),
                child: HeroBanner(slides: AppData.bannerSlides),
              ),
            ),

            // ── Featured Properties with 'الكل | للبيع | للإيجار' ──
            SliverToBoxAdapter(
              child: _FeaturedSectionHeader(
                selectedFilter: _featuredFilter,
                onFilterChanged: (idx) {
                  setState(() => _featuredFilter = idx);
                },
                onSeeAll: () {},
              ),
            ),
            SliverToBoxAdapter(
              child: _HorizontalPropertyList(
                items: _filteredFeaturedProperties,
              ),
            ),

            // ── Top Projects ───────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.only(top: AppSpacing.sectionSpacing),
                child: SectionHeader(
                  title: 'اهم المشاريع العقارية في مصر',
                  onSeeAll: () {},
                ),
              ),
            ),
            SliverToBoxAdapter(child: _buildProjectList()),

            // ── Search By City ─────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.only(top: AppSpacing.sectionSpacing),
                child: SectionHeader(
                    title: AppStrings.searchByCity, onSeeAll: () {}),
              ),
            ),
            SliverToBoxAdapter(child: _buildCityList()),

            // ── أحدث الشقق في مصر ─────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.only(top: AppSpacing.sectionSpacing),
                child: PropertySection(
                  title: AppStrings.latestApartments,
                  items: AppData.latestApartments,
                ),
              ),
            ),

            // ── أحدث الفيلات في مصر ───────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.only(top: AppSpacing.sectionSpacing),
                child: PropertySection(
                  title: AppStrings.latestVillas,
                  items: AppData.latestVillas,
                ),
              ),
            ),

            // ── أحدث الدوبلكس في مصر ──────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.only(top: AppSpacing.sectionSpacing),
                child: PropertySection(
                  title: 'أحدث الدوبلكس في مصر',
                  items: AppData.latestDuplexes,
                ),
              ),
            ),

            // ── أحدث الشاليهات في مصر ─────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.only(top: AppSpacing.sectionSpacing),
                child: PropertySection(
                  title: 'أحدث الشاليهات في مصر',
                  items: AppData.latestChalets,
                ),
              ),
            ),

            // ── أهم الأخبار ────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.only(top: AppSpacing.sectionSpacing),
                child: NewsSection(items: AppData.latestNews),
              ),
            ),

            const SliverToBoxAdapter(
                child: SizedBox(height: AppSpacing.xl)),
          ],
        ),
      ),
    );
  }

  // ── Top Header: Centered Logo + Row (Bell on Right & Menu on Left) + Search Bar ──
  Widget _buildTopHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(
        top: 8,
        bottom: 12,
      ),
      child: Column(
        children: [
          // Centered Logo
          Center(
            child: Image.asset(
              AppAssets.logoPng,
              height: 34,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => Text(
                'امتلاك',
                style: AppTextStyles.h2.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Row: Notification Bell (Right/Start) ─── 'المزيد' Menu (Left/End)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenHorizontal,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Notification Bell on right with bottom badge
                _NotificationBell(badge: 2, onTap: () {}),

                // 'المزيد' 3-lines menu button on left
                _MoreMenuButton(onTap: _openMore),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Search Bar integrated on white background
          HomeSearchBar(onTap: () {}),
        ],
      ),
    );
  }

  // ── Top Projects horizontal list ─────────────────────────────────
  Widget _buildProjectList() {
    return SizedBox(
      height: 260,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
            vertical: AppSpacing.sm),
        itemCount: AppData.topProjects.length,
        separatorBuilder: (_, __) =>
            const SizedBox(width: AppSpacing.itemSpacing),
        itemBuilder: (_, i) => ProjectCard(
          project: AppData.topProjects[i],
          width: 215,
          onTap: () {},
        ),
      ),
    );
  }

  // ── City list horizontal scroll ──────────────────────────────────
  Widget _buildCityList() {
    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
            vertical: AppSpacing.sm),
        itemCount: AppData.cities.length,
        separatorBuilder: (_, __) =>
            const SizedBox(width: AppSpacing.itemSpacing),
        itemBuilder: (_, i) =>
            CityCard(city: AppData.cities[i], onTap: () {}),
      ),
    );
  }
}

// ─── Featured Section Header with 'الكل | للبيع | للإيجار' ───────────
class _FeaturedSectionHeader extends StatelessWidget {
  final int selectedFilter;
  final ValueChanged<int> onFilterChanged;
  final VoidCallback onSeeAll;

  static const _filters = ['الكل', 'للبيع', 'للإيجار'];

  const _FeaturedSectionHeader({
    required this.selectedFilter,
    required this.onFilterChanged,
    required this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
        vertical: 6,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: Title on Right, 'مشاهدة الكل' on Left
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'عقارات مميزة في مصر',
                style: AppTextStyles.sectionTitle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              GestureDetector(
                onTap: onSeeAll,
                child: Text(
                  'مشاهدة الكل',
                  style: AppTextStyles.seeAll.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),

          // Row 2: 'الكل | للبيع | للإيجار' right under title, clearly legible and styled
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(_filters.length * 2 - 1, (i) {
                if (i.isOdd) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      '|',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFD1D5DB),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                }
                final idx = i ~/ 2;
                final isSelected = selectedFilter == idx;
                return GestureDetector(
                  onTap: () => onFilterChanged(idx),
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      _filters[idx],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight:
                            isSelected ? FontWeight.w800 : FontWeight.w500,
                        color: isSelected
                            ? AppColors.primary
                            : const Color(0xFF6B7280),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Notification Bell with Badge at Bottom ─────────────────────────
class _NotificationBell extends StatelessWidget {
  final int badge;
  final VoidCallback? onTap;

  const _NotificationBell({this.badge = 2, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 38,
        height: 38,
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Icon(
              Icons.notifications_none_rounded,
              size: 25,
              color: AppColors.textPrimary,
            ),
            if (badge > 0)
              Positioned(
                bottom: 2, // Badge positioned at bottom
                right: 4,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: const BoxDecoration(
                    color: AppColors.badgeRed,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '$badge',
                      style: AppTextStyles.badge.copyWith(
                        fontSize: 8,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ─── 'المزيد' 3-Lines Hamburger Menu Button ──────────────────────────
class _MoreMenuButton extends StatelessWidget {
  final VoidCallback onTap;

  const _MoreMenuButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.divider, width: 1.2),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 16,
                height: 2,
                decoration: BoxDecoration(
                  color: AppColors.textPrimary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 3),
              Container(
                width: 16,
                height: 2,
                decoration: BoxDecoration(
                  color: AppColors.textPrimary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 3),
              Container(
                width: 16,
                height: 2,
                decoration: BoxDecoration(
                  color: AppColors.textPrimary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Small horizontal property list (featured section) ─────────────
class _HorizontalPropertyList extends StatelessWidget {
  final List items;
  const _HorizontalPropertyList({required this.items});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 275,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
            vertical: AppSpacing.sm),
        itemCount: items.length,
        separatorBuilder: (_, __) =>
            const SizedBox(width: AppSpacing.itemSpacing),
        itemBuilder: (_, i) =>
            PropertyCard(property: items[i], width: 215, onTap: () {}),
      ),
    );
  }
}

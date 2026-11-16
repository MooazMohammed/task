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
  String _selectedCity = 'القاهرة';

  void _openMore() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  void _showCityPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final cities = [
          'القاهرة',
          'الجيزة',
          'الإسكندرية',
          'الشيخ زايد',
          'التجمع الخامس',
          'الساحل الشمالي',
        ];
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Text(
                    'اختر المدينة',
                    style: AppTextStyles.h3.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const Divider(),
                ...cities.map(
                  (city) => ListTile(
                    title: Text(
                      city,
                      style: AppTextStyles.body1.copyWith(
                        fontWeight: _selectedCity == city
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: _selectedCity == city
                            ? AppColors.primary
                            : AppColors.textPrimary,
                      ),
                    ),
                    trailing: _selectedCity == city
                        ? const Icon(Icons.check_circle_rounded,
                            color: AppColors.primary)
                        : null,
                    onTap: () {
                      setState(() => _selectedCity = city);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
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

            // ── Office Banner under Cities ────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: AppSpacing.sectionSpacing, bottom: AppSpacing.xs),
                child: HeroBanner(slides: AppData.officeBannerSlides),
              ),
            ),

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

  // ── Top Header: Centered Logo + Row (Location on Right & 3 Action Icons on Left) + Search Bar ──
  Widget _buildTopHeader() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0F000000),
            offset: const Offset(0, 4),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.only(
        top: 8,
        bottom: 16,
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
          const SizedBox(height: 12),

          // Row: Location on Right (Start in RTL) ─── 3 Action Icons on Left (End in RTL)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenHorizontal,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Right side: Location Dropdown
                _buildLocationDropdown(),

                // Left side: The 3 Action Icons (More Menu, Bell, Chat)
                _buildActionIconsGroup(),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Search Bar integrated on white background
          HomeSearchBar(onTap: () {}),
        ],
      ),
    );
  }

  // ── Location selector (Right side in RTL) ──
  Widget _buildLocationDropdown() {
    return InkWell(
      onTap: _showCityPicker,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _selectedCity,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.textPrimary,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  // ── Group of 3 Action Icons on Left: [More] [Bell] [Chat] ──
  Widget _buildActionIconsGroup() {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. More Menu (3 horizontal lines) on the far left
          _MoreMenuButton(onTap: _openMore),
          const SizedBox(width: 10),

          // 2. Notifications Bell with badge 2 in the middle
          _NotificationBell(
            badge: 2,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('لديك إشعاران جديدان', textAlign: TextAlign.right),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
          const SizedBox(width: 10),

          // 3. Chat / Messages with badge 5
          _ChatButton(
            badge: 5,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('لديك 5 رسائل جديدة', textAlign: TextAlign.right),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ── Top Projects horizontal list ─────────────────────────────────
  Widget _buildProjectList() {
    return SizedBox(
      height: 280,
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
      height: 215,
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

// ─── Notification Bell with Badge ───────────────────────────────────
class _NotificationBell extends StatelessWidget {
  final int badge;
  final VoidCallback? onTap;

  const _NotificationBell({this.badge = 2, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 38,
        height: 38,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            const Icon(
              Icons.notifications_none_rounded,
              size: 28,
              color: AppColors.textPrimary,
            ),
            if (badge > 0)
              Positioned(
                bottom: 2,
                right: 2,
                child: Container(
                  padding: const EdgeInsets.all(1.5),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
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
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          height: 1,
                        ),
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

// ─── Chat / Messages Button with Badge ──────────────────────────────
class _ChatButton extends StatelessWidget {
  final int badge;
  final VoidCallback? onTap;

  const _ChatButton({this.badge = 5, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 38,
        height: 38,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            const Icon(
              Icons.chat_bubble_outline_rounded,
              size: 26,
              color: AppColors.textPrimary,
            ),
            if (badge > 0)
              Positioned(
                bottom: 2,
                right: 2,
                child: Container(
                  padding: const EdgeInsets.all(1.5),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
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
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          height: 1,
                        ),
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
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 38,
        height: 38,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 22,
                height: 2.5,
                decoration: BoxDecoration(
                  color: AppColors.textPrimary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 4.5),
              Container(
                width: 22,
                height: 2.5,
                decoration: BoxDecoration(
                  color: AppColors.textPrimary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 4.5),
              Container(
                width: 22,
                height: 2.5,
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
      height: 288,
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

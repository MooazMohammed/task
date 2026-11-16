import 'package:flutter/material.dart';
import 'package:task/core/theme/app_colors.dart';
import 'package:task/core/theme/app_text_styles.dart';
import 'package:task/core/constants/app_models.dart';

/// Featured property card matching the exact Figma design in media_1794832231980_9a023d07.png:
/// - Badges at the bottom of the image: '★ مميز' (Right) and 'للبيع' (Left)
/// - Row 1: Price on Right, Red Heart on Left
/// - Row 2: Property title right-aligned
/// - Row 3: Specs (Bedrooms, Bathrooms, Area)
/// - Row 4: Location & Date on Right, 'بواسطة' + GS Agency logo on Left
class PropertyCard extends StatefulWidget {
  final PropertyModel property;
  final VoidCallback? onTap;
  final double width;
  final Color borderColor;

  const PropertyCard({
    super.key,
    required this.property,
    this.onTap,
    this.width = 215,
    this.borderColor = const Color(0xFFFFC700), // Yellow border matching Figma
  });

  @override
  State<PropertyCard> createState() => _PropertyCardState();
}

class _PropertyCardState extends State<PropertyCard> {
  late bool _isFav;

  @override
  void initState() {
    super.initState();
    _isFav = widget.property.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: widget.borderColor, width: 1.2),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0D000000),
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildImageWithBadges(),
            _buildInfo(),
          ],
        ),
      ),
    );
  }

  // ── Image with bottom badges ──────────────────────────────────────
  Widget _buildImageWithBadges() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
      child: AspectRatio(
        aspectRatio: 16 / 10,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              widget.property.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: AppColors.shimmerBase,
                child: const Icon(Icons.home, color: Colors.white54, size: 40),
              ),
            ),

            // Bottom bar with badges: '★ مميز' (Right) and 'للبيع' (Left)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Right badge (RTL start = right): '★ مميز'
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: const BoxDecoration(
                      color: AppColors.accent, // #FFC700
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(6)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.star,
                            size: 11, color: AppColors.textPrimary),
                        SizedBox(width: 3),
                        Text(
                          'مميز',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Left badge (RTL end = left): 'للبيع'
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 3),
                    decoration: const BoxDecoration(
                      color: AppColors.accent, // #FFC700
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(6)),
                    ),
                    child: Text(
                      widget.property.transactionType,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Property Info ────────────────────────────────────────────────
  Widget _buildInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Row 1: Price (Right in RTL) & Heart (Left in RTL)
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.property.rawPrice,
                  style: AppTextStyles.price.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 6),
              GestureDetector(
                onTap: () => setState(() => _isFav = !_isFav),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    _isFav ? Icons.favorite : Icons.favorite_border,
                    key: ValueKey(_isFav),
                    color: _isFav
                        ? AppColors.heartActive
                        : AppColors.textDisabled,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),

          // Row 2: Title (Right aligned)
          Text(
            widget.property.title,
            style: AppTextStyles.h3.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 5),

          // Row 3: Specs in exact order: 10 Rooms (Right) | 5 Baths (Middle) | 8.725sqft (Left)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSpecItem('${widget.property.bedrooms}', Icons.bed_outlined),
              _buildSpecItem(
                  '${widget.property.bathrooms}', Icons.bathtub_outlined),
              _buildSpecItem('8.725sqft', Icons.straighten_outlined),
            ],
          ),
          const SizedBox(height: 6),

          // Row 4: Bottom row: Location & Date on Right, Agency on Left
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Right side in RTL: Location and Date
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined,
                            size: 12, color: AppColors.textSecondary),
                        const SizedBox(width: 3),
                        Expanded(
                          child: Text(
                            widget.property.location,
                            style: AppTextStyles.caption.copyWith(fontSize: 10),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(Icons.access_time_rounded,
                            size: 11, color: AppColors.textSecondary),
                        const SizedBox(width: 3),
                        Expanded(
                          child: Text(
                            'منذ ${widget.property.daysAgo} ايام',
                            style:
                                AppTextStyles.caption.copyWith(fontSize: 9.5),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),

              // Left side in RTL: Agency logo (بواسطة + GS)
              _buildAgencyLogo(),
            ],
          ),
        ],
      ),
    );
  }

  // ── Spec item: number then icon ──────────────────────────────────
  Widget _buildSpecItem(String value, IconData icon) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: AppTextStyles.caption.copyWith(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(width: 3),
        Icon(icon, size: 12, color: AppColors.textSecondary),
      ],
    );
  }

  // ── GS Agency Logo ───────────────────────────────────────────────
  Widget _buildAgencyLogo() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'بواسطة',
          style: AppTextStyles.caption.copyWith(
            fontSize: 8.5,
            color: AppColors.textDisabled,
          ),
        ),
        const SizedBox(height: 2),
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFE53935), width: 1.2),
            boxShadow: const [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 3,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              'GS',
              style: TextStyle(
                color: Color(0xFFE53935),
                fontWeight: FontWeight.w900,
                fontSize: 9,
                letterSpacing: -0.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

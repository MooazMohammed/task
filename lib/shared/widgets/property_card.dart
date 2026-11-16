import 'package:flutter/material.dart';
import 'package:task/core/theme/app_colors.dart';
import 'package:task/core/theme/app_text_styles.dart';
import 'package:task/core/constants/app_models.dart';
import 'agency_logo.dart';
import 'spec_item.dart';

/// Featured property card matching the exact Figma design:
/// - Badges at bottom of image: '★ مميز' (Right) and 'للبيع' (Left)
/// - Price on Right, Red Heart on Left
/// - Property title right-aligned
/// - Specs (Bedrooms, Bathrooms, Area)
/// - Location & Date on Right, 'بواسطة' + GS Agency logo on Left
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
    this.borderColor = const Color(0xFFFFC700),
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
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _badgePill('★ مميز', isStar: true),
                  _badgePill(widget.property.transactionType),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _badgePill(String label, {bool isStar = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: const BoxDecoration(
        color: AppColors.accent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(6),
          topRight: Radius.circular(6),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
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
                child: Icon(
                  _isFav ? Icons.favorite : Icons.favorite_border,
                  color: _isFav ? AppColors.heartActive : AppColors.textDisabled,
                  size: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SpecItem(value: '${widget.property.bedrooms}', icon: Icons.bed_outlined),
              SpecItem(value: '${widget.property.bathrooms}', icon: Icons.bathtub_outlined),
              const SpecItem(value: '8.725sqft', icon: Icons.straighten_outlined),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(child: _buildLocationAndDate()),
              const SizedBox(width: 6),
              const AgencyLogo(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLocationAndDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const Icon(Icons.location_on_outlined, size: 12, color: AppColors.textSecondary),
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
            const Icon(Icons.access_time_rounded, size: 11, color: AppColors.textSecondary),
            const SizedBox(width: 3),
            Expanded(
              child: Text(
                'منذ ${widget.property.daysAgo} ايام',
                style: AppTextStyles.caption.copyWith(fontSize: 9.5),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:task/core/theme/app_colors.dart';
import 'package:task/core/theme/app_text_styles.dart';
import 'package:task/core/constants/app_models.dart';
import 'package:task/shared/widgets/agency_logo.dart';
import 'package:task/shared/widgets/spec_item.dart';

/// Horizontal split property card matching Figma:
/// - Right: Image with 'للبيع' translucent badge
/// - Left: Info (Price + Heart, Title, Specs, Location + Date + AgencyLogo)
class PropertyListCard extends StatefulWidget {
  final PropertyModel property;
  final VoidCallback? onTap;

  const PropertyListCard({
    super.key,
    required this.property,
    this.onTap,
  });

  @override
  State<PropertyListCard> createState() => _PropertyListCardState();
}

class _PropertyListCardState extends State<PropertyListCard> {
  late bool _isFav;

  @override
  void initState() {
    super.initState();
    _isFav = true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 168,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE5E7EB), width: 1.2),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildImage(),
            Expanded(child: _buildContent()),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return SizedBox(
      width: 152,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(right: Radius.circular(16)),
            child: CachedNetworkImage(
              imageUrl: widget.property.imageUrl,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(color: const Color(0xFF1E293B)),
              errorWidget: (_, __, ___) => Container(color: const Color(0xFFE2E8F0)),
            ),
          ),
          Positioned(
            top: 10,
            left: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: const BoxDecoration(
                color: Color(0xCCE2E8F0),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Text(
                widget.property.transactionType,
                style: const TextStyle(
                  color: Color(0xFF0F4C81),
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Cairo',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  widget.property.rawPrice,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                    fontFamily: 'Cairo',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _isFav = !_isFav),
                child: Icon(
                  _isFav ? Icons.favorite : Icons.favorite_border,
                  color: _isFav ? const Color(0xFFE53935) : AppColors.textDisabled,
                  size: 20,
                ),
              ),
            ],
          ),
          Text(
            widget.property.title,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF4A5568),
              fontFamily: 'Cairo',
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SpecItem(value: '${widget.property.bedrooms}', icon: Icons.bed_outlined),
              SpecItem(value: '${widget.property.bathrooms}', icon: Icons.bathtub_outlined),
              const SpecItem(value: '8,725sqft', icon: Icons.crop_free_rounded),
            ],
          ),
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
                style: AppTextStyles.caption.copyWith(fontSize: 9.5),
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
                style: AppTextStyles.caption.copyWith(fontSize: 9),
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

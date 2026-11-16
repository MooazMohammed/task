import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:task/core/theme/app_colors.dart';
import 'package:task/core/theme/app_text_styles.dart';
import 'package:task/core/constants/app_models.dart';

/// Horizontal split property card matching the exact design in media_1794839801828_3b60b7dd.png:
/// - Right side: Image with 'للبيع' translucent badge on top-left
/// - Left side: Info (Price + Heart, Title, Specs with bed/bath/area, Location & Date + GS Agency logo)
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
    _isFav = true; // Active red heart matching Image 2
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
            // ── Right side in RTL: Image with transaction badge ──
            _buildImage(),

            // ── Left side in RTL: Content info ──
            Expanded(child: _buildContent()),
          ],
        ),
      ),
    );
  }

  // ── Image section (Right half in RTL) ─────────────────────────────
  Widget _buildImage() {
    return SizedBox(
      width: 152,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(
              right: Radius.circular(16),
            ),
            child: CachedNetworkImage(
              imageUrl: widget.property.imageUrl,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(
                color: const Color(0xFF1E293B),
                child: const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white38,
                    ),
                  ),
                ),
              ),
              errorWidget: (_, __, ___) => Container(
                color: const Color(0xFFE2E8F0),
                child: const Icon(Icons.home, color: Colors.white54, size: 36),
              ),
            ),
          ),

          // Translucent badge on top-left of image: 'للبيع'
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

  // ── Content section (Left half in RTL) ────────────────────────────
  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Row 1: Price on Right, Red Heart on Left
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

          // Row 2: Title
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

          // Row 3: Specs in exact order: 10 Rooms | 5 Baths | 8,725sqft
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSpecItem('${widget.property.bedrooms}', Icons.bed_outlined),
              _buildSpecItem('${widget.property.bathrooms}', Icons.bathtub_outlined),
              _buildSpecItem('8,725sqft', Icons.crop_free_rounded),
            ],
          ),

          // Row 4: Location & Date on Right, Agency on Left
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
                        const Icon(
                          Icons.location_on_outlined,
                          size: 12,
                          color: AppColors.textSecondary,
                        ),
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
                        const Icon(
                          Icons.access_time_rounded,
                          size: 11,
                          color: AppColors.textSecondary,
                        ),
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
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            fontFamily: 'Cairo',
          ),
        ),
        const SizedBox(width: 3),
        Icon(icon, size: 13, color: AppColors.textPrimary),
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
        const SizedBox(height: 1),
        const Text(
          'GOLD SQUARE',
          style: TextStyle(
            color: Color(0xFFE53935),
            fontSize: 5,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
        ),
      ],
    );
  }
}

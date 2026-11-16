import 'package:flutter/material.dart';
import 'package:task/core/theme/app_colors.dart';
import 'package:task/core/theme/app_text_styles.dart';
import 'package:task/core/theme/app_spacing.dart';
import 'package:task/core/constants/app_models.dart';

/// Full-width horizontal property card — matches Figma list card design.
/// Image on RIGHT (RTL start), content on LEFT.
class PropertyListCard extends StatefulWidget {
  final PropertyModel property;
  final VoidCallback? onTap;

  const PropertyListCard({super.key, required this.property, this.onTap});

  @override
  State<PropertyListCard> createState() => _PropertyListCardState();
}

class _PropertyListCardState extends State<PropertyListCard> {
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
        height: 155,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Image (RIGHT in RTL = first child) ──────────────
            _buildImage(),
            // ── Content (LEFT in RTL = second child) ────────────
            _buildContent(),
          ],
        ),
      ),
    );
  }

  // ── Image section ─────────────────────────────────────────────
  Widget _buildImage() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.horizontal(
              right: Radius.circular(AppSpacing.cardRadius)),
          child: SizedBox(
            width: 148,
            child: Image.network(
              widget.property.imageUrl,
              fit: BoxFit.cover,
              height: 155,
              errorBuilder: (_, __, ___) =>
                  Container(color: AppColors.shimmerBase),
            ),
          ),
        ),
        // Favourite button — top-left of image (RTL: towards content)
        Positioned(
          top: 0,
          left: 0,
          child: GestureDetector(
            onTap: () => setState(() => _isFav = !_isFav),
            child: SizedBox(
              width: 40,
              height: 40,
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    _isFav ? Icons.favorite : Icons.favorite_border,
                    key: ValueKey(_isFav),
                    color: _isFav ? AppColors.heartActive : Colors.white,
                    size: 20,
                    shadows: const [
                      Shadow(color: Color(0x66000000), blurRadius: 8)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ── Content section ───────────────────────────────────────────
  Widget _buildContent() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Price + transaction badge
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    widget.property.rawPrice,
                    style: AppTextStyles.price.copyWith(fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 6),
                _badge(
                  widget.property.transactionType,
                  widget.property.transactionType == 'للبيع'
                      ? AppColors.secondary
                      : AppColors.info,
                ),
              ],
            ),
            // Title
            Text(
              widget.property.title,
              style: AppTextStyles.body1.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            // Specs row
            Row(
              children: [
                _spec(Icons.bed_outlined, '${widget.property.bedrooms}'),
                const SizedBox(width: 8),
                _spec(Icons.bathtub_outlined, '${widget.property.bathrooms}'),
                const SizedBox(width: 8),
                _spec(
                  Icons.straighten_outlined,
                  '${widget.property.area.toInt()}م²',
                ),
              ],
            ),
            // Location
            Row(
              children: [
                const Icon(Icons.location_on_outlined,
                    size: 11, color: AppColors.textSecondary),
                const SizedBox(width: 2),
                Expanded(
                  child: Text(
                    widget.property.location,
                    style: AppTextStyles.caption,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            // Agent + date
            Row(
              children: [
                const Icon(Icons.business_center_outlined,
                    size: 11, color: AppColors.textSecondary),
                const SizedBox(width: 3),
                Text(widget.property.agentName, style: AppTextStyles.caption),
                const Spacer(),
                const Icon(Icons.access_time_rounded,
                    size: 11, color: AppColors.textSecondary),
                const SizedBox(width: 2),
                Text('منذ ${widget.property.daysAgo} أيام',
                    style: AppTextStyles.caption),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _badge(String label, Color color) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          style: AppTextStyles.badge.copyWith(fontSize: 9),
        ),
      );

  Widget _spec(IconData icon, String v) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: AppColors.textSecondary),
          const SizedBox(width: 2),
          Text(v, style: AppTextStyles.caption),
        ],
      );
}

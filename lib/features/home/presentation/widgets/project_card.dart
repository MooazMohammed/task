import 'package:flutter/material.dart';
import 'package:task/core/theme/app_colors.dart';
import 'package:task/core/theme/app_text_styles.dart';
import 'package:task/core/constants/app_models.dart';

/// Top Project Card matching the exact Figma design in media_1794832231980_9a023d07.png:
/// - Green badge at the bottom of the image: '🏛️ مشروع'
/// - Row 1: Name on Right, Red Heart on Left
/// - Row 2: Subtitle/developer description right-aligned
/// - Row 3: Location & Date on Right, 'بواسطة' + GS Agency logo on Left
class ProjectCard extends StatefulWidget {
  final ProjectModel project;
  final VoidCallback? onTap;
  final double width;
  final Color borderColor;

  const ProjectCard({
    super.key,
    required this.project,
    this.onTap,
    this.width = 215,
    this.borderColor = const Color(0xFF00C853), // Green border matching Figma
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isFav = true;

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
            _buildImageWithBadge(),
            _buildInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageWithBadge() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
      child: AspectRatio(
        aspectRatio: 16 / 10,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              widget.project.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: const Color(0x4D0A2753),
                child: const Icon(Icons.apartment, color: Colors.white54, size: 40),
              ),
            ),

            // Green 'مشروع' pill badge on the right, slightly up from bottom
            Positioned(
              bottom: 8,
              right: 10,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF22A45D),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x33000000),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.domain_rounded, size: 14, color: Colors.white),
                    SizedBox(width: 4),
                    Text(
                      'مشروع',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
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
          // Row 1: Name (Right in RTL) & Heart (Left in RTL)
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.project.name,
                  style: AppTextStyles.h3.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
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

          // Row 2: Subtitle
          Text(
            'شقق سكنية فاخرة ومطاعم تجار...',
            style: AppTextStyles.body2.copyWith(
              fontSize: 10.5,
              color: AppColors.textSecondary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),

          // Row 3: Location & Date on Right, Agency on Left
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
                            widget.project.location,
                            style: AppTextStyles.caption.copyWith(fontSize: 10),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: const [
                        Icon(Icons.access_time_rounded,
                            size: 11, color: AppColors.textSecondary),
                        SizedBox(width: 3),
                        Expanded(
                          child: Text(
                            'منذ 4 ايام',
                            style: TextStyle(
                                fontSize: 9.5, color: AppColors.textSecondary),
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
            fontSize: 5.5,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
        ),
      ],
    );
  }
}

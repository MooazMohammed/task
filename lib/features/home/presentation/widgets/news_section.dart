import 'package:flutter/material.dart';
import 'package:task/core/theme/app_colors.dart';
import 'package:task/core/theme/app_text_styles.dart';
import 'package:task/core/theme/app_spacing.dart';
import 'package:task/core/constants/app_models.dart';
import 'package:task/shared/widgets/section_header.dart';

/// أهم الأخبار section — 2-column grid of news cards, matches Figma.
class NewsSection extends StatelessWidget {
  final List<NewsModel> items;

  const NewsSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(title: 'أهم الأخبار', onSeeAll: () {}),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenHorizontal),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items
                .take(2)
                .map((n) => Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          // gap only between cards, not on outer edges
                          left: items.indexOf(n) == 0 ? AppSpacing.xs : 0,
                          right: items.indexOf(n) == 1 ? AppSpacing.xs : 0,
                        ),
                        child: _NewsCard(news: n),
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _NewsCard extends StatelessWidget {
  final NewsModel news;

  const _NewsCard({required this.news});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          boxShadow: const [
            BoxShadow(
              color: Color(0x10000000),
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Image ──────────────────────────────────────────
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppSpacing.cardRadius)),
              child: AspectRatio(
                aspectRatio: 16 / 10,
                child: Image.network(
                  news.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      Container(color: AppColors.shimmerBase),
                ),
              ),
            ),
            // ── Text content ───────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.title,
                    style: AppTextStyles.h3.copyWith(fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    news.description,
                    style: AppTextStyles.caption.copyWith(height: 1.5),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:task/core/theme/app_spacing.dart';
import 'package:task/core/constants/app_models.dart';
import 'package:task/shared/widgets/section_header.dart';
import 'news_card.dart';

/// أهم الأخبار section — 2-column grid of news cards
class NewsSection extends StatelessWidget {
  final List<NewsModel> items;

  const NewsSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(title: 'أهم الأخبار', onSeeAll: () {}),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenHorizontal),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items
                .take(2)
                .map((n) => Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: items.indexOf(n) == 0 ? AppSpacing.xs : 0,
                          right: items.indexOf(n) == 1 ? AppSpacing.xs : 0,
                        ),
                        child: NewsCard(news: n),
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}

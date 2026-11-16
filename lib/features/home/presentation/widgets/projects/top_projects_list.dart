import 'package:flutter/material.dart';
import 'package:task/core/theme/app_spacing.dart';
import 'package:task/core/constants/app_models.dart';
import '../project_card.dart';

/// Horizontal scrolling list of top real estate projects
class TopProjectsList extends StatelessWidget {
  final List<ProjectModel> projects;
  final ValueChanged<ProjectModel>? onProjectTap;

  const TopProjectsList({
    super.key,
    required this.projects,
    this.onProjectTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenHorizontal,
          vertical: AppSpacing.sm,
        ),
        itemCount: projects.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.itemSpacing),
        itemBuilder: (_, i) => ProjectCard(
          project: projects[i],
          width: 215,
          onTap: () => onProjectTap?.call(projects[i]),
        ),
      ),
    );
  }
}

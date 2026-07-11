import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/community_controller.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../cards/post_card.dart';

class CommunityContent extends StatelessWidget {
  const CommunityContent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CommunityController>();

    if (controller.isLoading && controller.posts.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }

    if (controller.errorMessage != null && controller.posts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 48,
              color: AppColors.textCaption,
            ),
            const SizedBox(height: 16),
            Text(
              controller.errorMessage!,
              style: AppTypography.body2Regular(color: AppColors.textCaption),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: controller.fetchPosts,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (controller.filteredPosts.isEmpty) {
      return RefreshIndicator(
        onRefresh: controller.fetchPosts,
        color: AppColors.primary,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            const SizedBox(height: 60),
            Center(
              child: Text(
                'No posts found.',
                style: AppTypography.body2Regular(color: AppColors.textCaption),
              ),
            ),
          ],
        ),
      );
    }

    final currentUserId = context.watch<AuthController>().userProfile?['id'];

    return RefreshIndicator(
      onRefresh: controller.fetchPosts,
      color: AppColors.primary,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: controller.filteredPosts.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) => PostCard(
          post: controller.filteredPosts[index],
          currentUserId: currentUserId,
        ),
      ),
    );
  }
}

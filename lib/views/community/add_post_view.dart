import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/community_controller.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../widgets/common/app_primary_button.dart';
import '../../models/post_model.dart';

class AddPostView extends StatelessWidget {
  final PostModel? postToEdit;

  const AddPostView({super.key, this.postToEdit});

  @override
  Widget build(BuildContext context) {
    final communityController = context.watch<CommunityController>();
    final isEditing = postToEdit != null;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          isEditing ? 'Edit Post' : 'New Post',
          style: AppTypography.titleSemiBold(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textHeading),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: communityController.postSubjectController,
              style: AppTypography.body1Regular(),
              decoration: const InputDecoration(hintText: 'Subject'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: communityController.postContentController,
              maxLines: 8,
              style: AppTypography.body1Regular(),
              decoration: const InputDecoration(
                hintText: 'Write something about this moment...',
              ),
            ),
            const SizedBox(height: 32),
            communityController.isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  )
                : AppPrimaryButton(
                    label: isEditing ? 'Save Changes' : 'Share Post',
                    onPressed: () async {
                      if (isEditing) {
                        final subject = communityController
                            .postSubjectController
                            .text
                            .trim();
                        final content = communityController
                            .postContentController
                            .text
                            .trim();

                        if (subject.isEmpty || content.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please write a subject and content!',
                              ),
                            ),
                          );
                          return;
                        }

                        final success = await context
                            .read<CommunityController>()
                            .updatePost(
                              postToEdit!.id,
                              subject,
                              content,
                              context,
                            );
                        if (success && context.mounted) {
                          Navigator.pop(context);
                        }
                      } else {
                        await context.read<CommunityController>().createPost(
                          context,
                        );
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }
}

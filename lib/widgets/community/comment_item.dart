import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/community_controller.dart';
import '../../models/comment_model.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';

class CommentItem extends StatelessWidget {
  final CommentModel comment;
  final String? currentUserId;
  final Function(CommentModel) onReply;
  final VoidCallback onRefresh;

  const CommentItem({
    super.key,
    required this.comment,
    required this.currentUserId,
    required this.onReply,
    required this.onRefresh,
  });

  String _timeAgo(DateTime date) {
    final difference = DateTime.now().difference(date);
    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()}y ago';
    }
    if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()}mo ago';
    }
    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    }
    if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    }
    if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    }
    return 'Just now';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: comment.author.avatarColor,
                child: Icon(
                  Icons.person,
                  size: 16,
                  color: comment.author.avatarColor.computeLuminance() > 0.5
                      ? Colors.black54
                      : Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          comment.author.name,
                          style: AppTypography.body2SemiBold(),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          comment.updatedAt.isAfter(
                                comment.createdAt.add(
                                  const Duration(seconds: 1),
                                ),
                              )
                              ? '${_timeAgo(comment.updatedAt)} (Edited)'
                              : _timeAgo(comment.createdAt),
                          style: AppTypography.smallDescriptionRegular(
                            color: AppColors.textCaption,
                          ).copyWith(fontSize: 11),
                        ),
                        const Spacer(),
                        CommentMenu(
                          comment: comment,
                          currentUserId: currentUserId,
                          onRefresh: onRefresh,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(comment.text, style: AppTypography.body2Regular()),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () => onReply(comment),
                      child: Text(
                        'Reply',
                        style: AppTypography.smallDescriptionSemiBold(
                          color: AppColors.primary,
                        ).copyWith(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (comment.replies.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 44, top: 12),
              child: Column(
                children: comment.replies
                    .map(
                      (reply) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 12,
                              backgroundColor: reply.author.avatarColor,
                              child: Icon(
                                Icons.person,
                                size: 12,
                                color:
                                    reply.author.avatarColor
                                            .computeLuminance() >
                                        0.5
                                    ? Colors.black54
                                    : Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        reply.author.name,
                                        style: AppTypography.body2SemiBold()
                                            .copyWith(fontSize: 12),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        reply.updatedAt.isAfter(
                                              reply.createdAt.add(
                                                const Duration(seconds: 1),
                                              ),
                                            )
                                            ? '${_timeAgo(reply.updatedAt)} (Edited)'
                                            : _timeAgo(reply.createdAt),
                                        style:
                                            AppTypography.smallDescriptionRegular(
                                              color: AppColors.textCaption,
                                            ).copyWith(fontSize: 10),
                                      ),
                                      const Spacer(),
                                      CommentMenu(
                                        comment: reply,
                                        currentUserId: currentUserId,
                                        isReply: true,
                                        onRefresh: onRefresh,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    reply.text,
                                    style: AppTypography.body2Regular()
                                        .copyWith(fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}

class CommentMenu extends StatelessWidget {
  final CommentModel comment;
  final String? currentUserId;
  final bool isReply;
  final VoidCallback onRefresh;

  const CommentMenu({
    super.key,
    required this.comment,
    required this.currentUserId,
    this.isReply = false,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: Colors.white,
      padding: EdgeInsets.zero,
      icon: const Icon(
        Icons.more_horiz,
        color: AppColors.textCaption,
        size: 16,
      ),
      onSelected: (value) async {
        if (value == 'edit') {
          final textController = TextEditingController(text: comment.text);
          final confirm = await showDialog<bool>(
            context: context,
            builder: (ctx) => AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text('Edit Comment', style: AppTypography.titleSemiBold()),
              content: TextField(
                controller: textController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Write a comment...',
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx, false),
                  child: Text(
                    'Cancel',
                    style: AppTypography.body1Regular(
                      color: AppColors.textCaption,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(ctx, true),
                  child: Text(
                    'Save',
                    style: AppTypography.body1SemiBold(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          );

          if (confirm == true && context.mounted) {
            await context.read<CommunityController>().updateComment(
              comment.id,
              textController.text,
              context,
            );
            onRefresh();
          }
        } else if (value == 'delete') {
          final confirm = await showDialog<bool>(
            context: context,
            builder: (ctx) => AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text(
                'Delete Comment?',
                style: AppTypography.titleSemiBold(),
              ),
              content: Text(
                'This comment will be permanently deleted.',
                style: AppTypography.body1Regular(color: AppColors.textCaption),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx, false),
                  child: Text(
                    'Cancel',
                    style: AppTypography.body1SemiBold(
                      color: AppColors.textCaption,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(ctx, true),
                  child: Text(
                    'Delete',
                    style: AppTypography.body1SemiBold(
                      color: AppColors.moodStress,
                    ),
                  ),
                ),
              ],
            ),
          );

          if (confirm == true && context.mounted) {
            await context.read<CommunityController>().deleteComment(
              comment.id,
              context,
            );
            onRefresh();
          }
        } else if (value == 'report') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Thank you, your report has been received.'),
            ),
          );
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        if (currentUserId != null && currentUserId == comment.author.id) ...[
          PopupMenuItem<String>(
            value: 'edit',
            child: Text('Edit Comment', style: AppTypography.body2Medium()),
          ),
          PopupMenuItem<String>(
            value: 'delete',
            child: Text(
              'Delete Comment',
              style: AppTypography.body2Medium(color: AppColors.moodStress),
            ),
          ),
        ] else
          PopupMenuItem<String>(
            value: 'report',
            child: Text('Report', style: AppTypography.body2Medium()),
          ),
      ],
    );
  }
}

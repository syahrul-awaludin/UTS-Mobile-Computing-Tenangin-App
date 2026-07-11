import 'package:flutter/material.dart';
import '../../models/comment_model.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';

class CommentInput extends StatelessWidget {
  final CommentModel? replyingTo;
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onSubmit;
  final VoidCallback onCancelReply;

  const CommentInput({
    super.key,
    required this.replyingTo,
    required this.controller,
    required this.focusNode,
    required this.onSubmit,
    required this.onCancelReply,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.borderDefault)),
      ),
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: 12 + MediaQuery.of(context).padding.bottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (replyingTo != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Text('Replying to ', style: AppTypography.smallDescriptionRegular(color: AppColors.textCaption).copyWith(fontSize: 12)),
                  Text(replyingTo!.userName, style: AppTypography.smallDescriptionSemiBold(color: AppColors.primary).copyWith(fontSize: 12)),
                  const Spacer(),
                  GestureDetector(
                    onTap: onCancelReply,
                    child: const Icon(Icons.close, size: 16, color: AppColors.textCaption),
                  )
                ],
              ),
            ),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: controller,
                    focusNode: focusNode,
                    style: AppTypography.body1Regular(),
                    decoration: InputDecoration(
                      hintText: 'Write a comment...',
                      border: InputBorder.none,
                      hintStyle: AppTypography.body1Regular(color: AppColors.textCaption),
                    ),
                    maxLines: null,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: onSubmit,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.send, color: Colors.white, size: 18),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../models/comment_model.dart';
import '../../theme/app_colors.dart';

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
                  const Text('Replying to ', style: TextStyle(fontFamily: 'Inter', fontSize: 12, color: AppColors.textCaption)),
                  Text(replyingTo!.userName, style: const TextStyle(fontFamily: 'Inter', fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary)),
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
                    decoration: const InputDecoration(
                      hintText: 'Write a comment...',
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: AppColors.textCaption, fontSize: 14),
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

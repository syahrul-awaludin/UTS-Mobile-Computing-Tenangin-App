import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_colors.dart';
import '../../models/post_model.dart';
import '../../controllers/community_controller.dart';
import '../../views/community/post_detail_view.dart';
import '../../views/community/add_post_view.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  final String? currentUserId;
  final bool isDetail;

  const PostCard({super.key, required this.post, this.currentUserId, this.isDetail = false});

  void _navigateToDetail(BuildContext context) {
    if (isDetail) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostDetailView(
          post: post,
          currentUserId: currentUserId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToDetail(context),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPostHeader(context),
              const SizedBox(height: 16),
              Text(
                post.subject,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textHeading,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                post.content,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textHeading,
                  height: 1.4,
                ),
              ),
      if (post.imageAsset != null) ...[
        const SizedBox(height: 16),
        post.imageAsset!.startsWith('/') 
          ? _buildFileImage(post.imageAsset!)
          : _buildPostImage(),
      ],
              const SizedBox(height: 16),
              _buildActionBar(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPostHeader(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: post.author.avatarColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            post.author.avatarIcon,
            color: post.author.avatarColor == const Color(0xFFB8E6D0)
                ? const Color(0xFF4CAF50)
                : AppColors.primary,
            size: 24,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.author.name,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textHeading,
                ),
              ),
              const SizedBox(height: 4),
              _TimeAgoText(createdAt: post.createdAt),
            ],
          ),
        ),
        PopupMenuButton<String>(
          color: Colors.white,
          icon: const Icon(Icons.more_vert, color: AppColors.textCaption, size: 24),
          onSelected: (value) async {
            if (value == 'edit') {
              final communityController = context.read<CommunityController>();
              communityController.postSubjectController.text = post.subject;
              communityController.postContentController.text = post.content;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddPostView(postToEdit: post),
                ),
              );
            } else if (value == 'delete') {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  title: const Text(
                    'Delete Post?',
                    style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.bold, color: AppColors.textHeading),
                  ),
                  content: const Text(
                    'Deleted posts cannot be recovered.',
                    style: TextStyle(fontFamily: 'Inter', color: AppColors.textCaption),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, false),
                      child: const Text('Cancel', style: TextStyle(fontFamily: 'Inter', color: AppColors.textCaption, fontWeight: FontWeight.w600)),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, true),
                      child: const Text('Delete', style: TextStyle(fontFamily: 'Inter', color: AppColors.moodStress, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              );

              if (confirm == true && context.mounted) {
                await context.read<CommunityController>().deletePost(post.id, context);
              }
            } else if (value == 'report') {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Thank you, your report has been received.')),
              );
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            if (currentUserId != null && currentUserId == post.author.id) ...[
              const PopupMenuItem<String>(
                value: 'edit',
                child: Text('Edit Post', style: TextStyle(fontFamily: 'Inter', color: AppColors.textHeading, fontWeight: FontWeight.w500)),
              ),
              const PopupMenuItem<String>(
                value: 'delete',
                child: Text('Delete Post', style: TextStyle(fontFamily: 'Inter', color: AppColors.moodStress, fontWeight: FontWeight.w500)),
              ),
            ] else
              const PopupMenuItem<String>(
                value: 'report',
                child: Text('Report', style: TextStyle(fontFamily: 'Inter', color: AppColors.textHeading, fontWeight: FontWeight.w500)),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildPostImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        height: 240,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF5B3FD6), Color(0xFF7B5CE8)],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CustomPaint(
                size: const Size(double.infinity, 80),
                painter: _WavePainter(),
              ),
            ),
            Center(
              child: CustomPaint(
                size: const Size(200, 120),
                painter: _RainbowPainter(),
              ),
            ),
            Positioned(
                left: 30,
                bottom: 60,
                child: _buildCloud(40)),
            Positioned(
                right: 20,
                bottom: 70,
                child: _buildCloud(35)),
            Positioned(
                left: 80,
                bottom: 50,
                child: _buildCloud(30)),
            Positioned(
                right: 60,
                bottom: 55,
                child: _buildCloud(25)),
          ],
        ),
      ),
    );
  }

  Widget _buildFileImage(String path) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.file(
        File(path),
        width: double.infinity,
        height: 240,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildCloud(double width) {
    return Container(
      width: width,
      height: width * 0.5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(width * 0.25),
      ),
    );
  }

  Widget _buildActionBar(BuildContext context) {
    return Column(
      children: [
        const Divider(height: 1, color: AppColors.borderDefault),
        const SizedBox(height: 8),
        Row(
          children: [
            const SizedBox(width: 8),
            _buildActionButton(
              post.isLikedByMe ? Icons.favorite : Icons.favorite_border,
              post.likeCount.toString(),
              color: post.isLikedByMe ? AppColors.moodStress : AppColors.textHeading,
              onTap: () {
                context.read<CommunityController>().toggleLike(post.id, context);
              },
            ),
            const Spacer(),
            _buildActionButton(
              Icons.chat_bubble_outline,
              post.commentCount.toString(),
              onTap: () => _navigateToDetail(context),
            ),
            const Spacer(),
            _buildActionButton(
              Icons.bookmark_border,
              post.bookmarkCount.toString(),
              onTap: () {},
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {},
              child: const Icon(Icons.share_outlined,
                  color: AppColors.textHeading, size: 20),
            ),
            const SizedBox(width: 8),
          ],
        ),
        const SizedBox(height: 8),
        const Divider(height: 1, color: AppColors.borderDefault),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String count, {Color? color, VoidCallback? onTap}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color ?? AppColors.textHeading, size: 20),
            const SizedBox(width: 8),
            Text(count,
                style: TextStyle(
                    fontSize: 13, color: color ?? AppColors.textHeading)),
          ],
        ),
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4A35B0).withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(0, size.height * 0.5)
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.2,
          size.width * 0.5, size.height * 0.5)
      ..quadraticBezierTo(
          size.width * 0.75, size.height * 0.8, size.width, size.height * 0.4)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _RainbowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final colors = [
      const Color(0xFFFF6B6B), const Color(0xFFFF9F43),
      const Color(0xFFFFD166), const Color(0xFF7BCC70),
      const Color(0xFF48BFE3), const Color(0xFFAEC6F3),
      const Color(0xFFF2B5D4),
    ];
    final center = Offset(size.width / 2, size.height);
    for (int i = 0; i < colors.length; i++) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: 90.0 - (i * 10)),
        3.14159, 3.14159, false,
        Paint()
          ..color = colors[i]
          ..style = PaintingStyle.stroke
          ..strokeWidth = 10,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _TimeAgoText extends StatefulWidget {
  final DateTime createdAt;

  const _TimeAgoText({required this.createdAt});

  @override
  State<_TimeAgoText> createState() => _TimeAgoTextState();
}

class _TimeAgoTextState extends State<_TimeAgoText> {
  late Timer _timer;
  String _timeAgo = '';

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      _updateTime();
    });
  }

  @override
  void didUpdateWidget(covariant _TimeAgoText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.createdAt != oldWidget.createdAt) {
      _updateTime();
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateTime() {
    final difference = DateTime.now().difference(widget.createdAt);
    String newTimeAgo = '';
    if (difference.inDays > 0) {
      newTimeAgo = '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      newTimeAgo = '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      newTimeAgo = '${difference.inMinutes}m ago';
    } else {
      newTimeAgo = 'Just now';
    }

    if (newTimeAgo != _timeAgo) {
      if (mounted) {
        setState(() {
          _timeAgo = newTimeAgo;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _timeAgo,
      style: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 12,
        color: AppColors.textCaption,
      ),
    );
  }
}

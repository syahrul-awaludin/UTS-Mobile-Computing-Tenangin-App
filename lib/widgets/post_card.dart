import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class PostCard extends StatelessWidget {
  final String userName;
  final String timeAgo;
  final String content;
  final String? imageAsset;
  final Color avatarColor;
  final IconData avatarIcon;
  final int likeCount;
  final int commentCount;
  final int bookmarkCount;

  const PostCard({
    super.key,
    required this.userName,
    required this.timeAgo,
    required this.content,
    this.imageAsset,
    this.avatarColor = const Color(0xFFB8E6D0),
    this.avatarIcon = Icons.person,
    this.likeCount = 375,
    this.commentCount = 763,
    this.bookmarkCount = 763,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Post Header
            _buildPostHeader(),
            const SizedBox(height: 16),

            // Post Content Text
            Text(
              content,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.textHeading,
                height: 1.4,
              ),
            ),

            // Post Image (optional)
            if (imageAsset != null) ...[
              const SizedBox(height: 16),
              _buildPostImage(),
            ],

            const SizedBox(height: 16),

            // Action Buttons
            _buildActionBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildPostHeader() {
    return Row(
      children: [
        // Avatar
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: avatarColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            avatarIcon,
            color: avatarColor == const Color(0xFFB8E6D0)
                ? const Color(0xFF4CAF50)
                : AppColors.primary,
            size: 24,
          ),
        ),
        const SizedBox(width: 12),

        // User name + time
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textHeading,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                timeAgo,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textCaption,
                ),
              ),
            ],
          ),
        ),

        // More button (vertical dots)
        GestureDetector(
          onTap: () {},
          child: const Icon(
            Icons.more_vert,
            color: AppColors.textCaption,
            size: 24,
          ),
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
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF6B4DE6),
              Color(0xFF8B6CF7),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            // Background gradient
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF5B3FD6),
                    Color(0xFF7B5CE8),
                  ],
                ),
              ),
            ),

            // Decorative elements — waves and confetti
            // Bottom wave
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CustomPaint(
                size: const Size(double.infinity, 80),
                painter: _WavePainter(),
              ),
            ),

            // Rainbow arc
            Center(
              child: CustomPaint(
                size: const Size(200, 120),
                painter: _RainbowPainter(),
              ),
            ),

            // Cloud decorations
            Positioned(
              left: 30,
              bottom: 60,
              child: _buildCloud(40),
            ),
            Positioned(
              right: 20,
              bottom: 70,
              child: _buildCloud(35),
            ),
            Positioned(
              left: 80,
              bottom: 50,
              child: _buildCloud(30),
            ),
            Positioned(
              right: 60,
              bottom: 55,
              child: _buildCloud(25),
            ),

            // Decorative squiggles
            Positioned(
              top: 30,
              left: 40,
              child: _buildSquiggle(const Color(0xFF88D4F0)),
            ),
            Positioned(
              top: 20,
              right: 50,
              child: _buildSquiggle(const Color(0xFFFFD166)),
            ),
            Positioned(
              top: 60,
              right: 20,
              child: _buildSquiggle(const Color(0xFFFF8A65)),
            ),
            Positioned(
              bottom: 90,
              left: 15,
              child: _buildSquiggle(const Color(0xFF88D4F0)),
            ),
          ],
        ),
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

  Widget _buildSquiggle(Color color) {
    return CustomPaint(
      size: const Size(20, 15),
      painter: _SquigglePainter(color: color),
    );
  }

  Widget _buildActionBar() {
    return Column(
      children: [
        const Divider(height: 1, color: AppColors.borderDefault),
        const SizedBox(height: 8),
        Row(
          children: [
            const SizedBox(width: 8),
            // Like
            _buildActionButton(Icons.favorite_border, likeCount.toString()),
            const Spacer(),
            // Comment
            _buildActionButton(Icons.chat_bubble_outline, commentCount.toString()),
            const Spacer(),
            // Bookmark
            _buildActionButton(Icons.bookmark_border, bookmarkCount.toString()),
            const Spacer(),
            // Share
            GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.share_outlined,
                color: AppColors.textHeading,
                size: 20,
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
        const SizedBox(height: 8),
        const Divider(height: 1, color: AppColors.borderDefault),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String count) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.textHeading, size: 20),
          const SizedBox(width: 8),
          Text(
            count,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppColors.textHeading,
            ),
          ),
        ],
      ),
    );
  }
}

// Custom painter for the wave at the bottom of the image
class _WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4A35B0).withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.5);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.2,
      size.width * 0.5,
      size.height * 0.5,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.8,
      size.width,
      size.height * 0.4,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom painter for the rainbow arc
class _RainbowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final colors = [
      const Color(0xFFFF6B6B),
      const Color(0xFFFF9F43),
      const Color(0xFFFFD166),
      const Color(0xFF7BCC70),
      const Color(0xFF48BFE3),
      const Color(0xFFAEC6F3),
      const Color(0xFFF2B5D4),
    ];

    final center = Offset(size.width / 2, size.height);

    for (int i = 0; i < colors.length; i++) {
      final radius = 90.0 - (i * 10);
      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.stroke
        ..strokeWidth = 10;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        3.14159, // PI — start from left
        3.14159, // PI — half circle
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom painter for squiggle/confetti decorations
class _SquigglePainter extends CustomPainter {
  final Color color;
  _SquigglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(0, size.height * 0.5);
    path.quadraticBezierTo(
      size.width * 0.25,
      0,
      size.width * 0.5,
      size.height * 0.5,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height,
      size.width,
      size.height * 0.5,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

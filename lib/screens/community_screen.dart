import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/post_card.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'Community',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textHeading,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.textHeading),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.tune, color: AppColors.textHeading),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          // Post 1 — Mark Stephen (with image)
          const PostCard(
            userName: 'Mark Stephen',
            timeAgo: '3 hr ago',
            content: 'One small positive thought in the morning can change your whole day.',
            imageAsset: 'rainbow',
            avatarColor: Color(0xFFB8E6D0),
            avatarIcon: Icons.emoji_emotions_outlined,
            likeCount: 375,
            commentCount: 763,
            bookmarkCount: 763,
          ),
          const SizedBox(height: 12),

          // Post 2 — Stephanie Mora (text only)
          const PostCard(
            userName: 'Stephanie Mora',
            timeAgo: '3 hr ago',
            content: 'Reminder: You\'ve survived 100% of your worst days so far. Keep going!',
            avatarColor: Color(0xFFF5D0E0),
            avatarIcon: Icons.favorite,
            likeCount: 375,
            commentCount: 763,
            bookmarkCount: 763,
          ),
          const SizedBox(height: 12),

          // Post 3 — Naila Hamburg (text only)
          const PostCard(
            userName: 'Naila Hamburg',
            timeAgo: '3 hr ago',
            content: 'Dancing like nobody\'s watching because it makes me happy.',
            avatarColor: Color(0xFFD4C5F9),
            avatarIcon: Icons.music_note,
            likeCount: 375,
            commentCount: 763,
            bookmarkCount: 763,
          ),
          const SizedBox(height: 12),

          // Post 4 — Maria Jessica (text only)
          const PostCard(
            userName: 'Maria Jessica',
            timeAgo: '3 hr ago',
            content: 'Let\'s lift each other up today. Drop a heart if you\'re choosing positivity 💜',
            avatarColor: Color(0xFFFFE0B2),
            avatarIcon: Icons.person,
            likeCount: 375,
            commentCount: 763,
            bookmarkCount: 763,
          ),
          const SizedBox(height: 80), // Extra space for FAB
        ],
      ),
      floatingActionButton: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF9B7EF8),
              Color(0xFF7B5CE8),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          onPressed: () {},
          child: const Icon(Icons.add, color: Colors.white, size: 28),
        ),
      ),
    );
  }
}

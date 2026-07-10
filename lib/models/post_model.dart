import 'package:flutter/material.dart';

class PostModel {
  final String id;
  final String authorId;
  final String userName;
  final String subject;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String content;
  final String? imageAsset;
  final Color avatarColor;
  final IconData avatarIcon;
  final int likeCount;
  final int commentCount;
  final int bookmarkCount;
  final bool isLikedByMe;

  const PostModel({
    required this.id,
    required this.authorId,
    required this.userName,
    required this.subject,
    required this.createdAt,
    required this.updatedAt,
    required this.content,
    this.imageAsset,
    required this.avatarColor,
    required this.avatarIcon,
    this.likeCount = 0,
    this.commentCount = 0,
    this.bookmarkCount = 0,
    this.isLikedByMe = false,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    // Extract author details
    final author = json['author'] ?? {};
    final userName = author['name'] ?? 'Anonymous';
    final authorId = author['id'] ?? '';
    final id = json['id'] ?? '';

    // Generate a pseudo-random color based on user name length for consistency
    final colors = [
      const Color(0xFFB8E6D0),
      const Color(0xFFF5D0E0),
      const Color(0xFFD4C5F9),
      const Color(0xFFFFE0B2),
      const Color(0xFFE1F5FE),
    ];
    final Color avatarColor = colors[userName.length % colors.length];

    // Parse createdAt and updatedAt
    final createdAt = json['createdAt'] != null ? DateTime.parse(json['createdAt']).toLocal() : DateTime.now();
    final updatedAt = json['updatedAt'] != null ? DateTime.parse(json['updatedAt']).toLocal() : createdAt;

    final stats = json['stats'] ?? {};

    return PostModel(
      id: id,
      authorId: authorId,
      userName: userName,
      subject: json['subject'] ?? 'Post',
      createdAt: createdAt,
      updatedAt: updatedAt,
      content: json['content'] ?? '',
      avatarColor: avatarColor,
      avatarIcon: Icons.person,
      likeCount: stats['likeCount'] ?? 0,
      commentCount: stats['commentCount'] ?? 0,
      bookmarkCount: stats['bookmarkCount'] ?? 0,
      isLikedByMe: json['isLikedByMe'] ?? false,
    );
  }
}

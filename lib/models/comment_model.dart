import 'package:flutter/material.dart';

class CommentModel {
  final String id;
  final String postId;
  final String authorId;
  final String userName;
  final String text;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Color avatarColor;
  final List<CommentModel> replies;

  const CommentModel({
    required this.id,
    required this.postId,
    required this.authorId,
    required this.userName,
    required this.text,
    required this.createdAt,
    required this.updatedAt,
    required this.avatarColor,
    this.replies = const [],
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    final author = json['author'] ?? {};
    final userName = author['name'] ?? 'Anonymous';
    final authorId = author['id'] ?? '';

    // Generate a pseudo-random color based on user name length for consistency
    final colors = [
      const Color(0xFFB8E6D0),
      const Color(0xFFF5D0E0),
      const Color(0xFFD4C5F9),
      const Color(0xFFFFE0B2),
      const Color(0xFFE1F5FE),
    ];
    final Color avatarColor = colors[userName.length % colors.length];

    final createdAt = json['createdAt'] != null
        ? DateTime.parse(json['createdAt']).toLocal()
        : DateTime.now();

    final updatedAt = json['updatedAt'] != null
        ? DateTime.parse(json['updatedAt']).toLocal()
        : createdAt;

    final repliesJson = json['replies'] as List<dynamic>? ?? [];
    final replies = repliesJson
        .map((replyJson) => CommentModel.fromJson(replyJson))
        .toList();

    return CommentModel(
      id: json['id'] ?? '',
      postId: json['postId'] ?? '',
      authorId: authorId,
      userName: userName,
      text: json['text'] ?? '',
      createdAt: createdAt,
      updatedAt: updatedAt,
      avatarColor: avatarColor,
      replies: replies,
    );
  }
}

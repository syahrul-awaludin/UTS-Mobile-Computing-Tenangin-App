import 'user_model.dart';

class PostModel {
  final String id;
  final UserModel author;
  final String subject;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String content;
  final String? imageAsset;
  final int likeCount;
  final int commentCount;
  final int bookmarkCount;
  final bool isLikedByMe;

  const PostModel({
    required this.id,
    required this.author,
    required this.subject,
    required this.createdAt,
    required this.updatedAt,
    required this.content,
    this.imageAsset,
    this.likeCount = 0,
    this.commentCount = 0,
    this.bookmarkCount = 0,
    this.isLikedByMe = false,
  });

  PostModel copyWith({
    String? id,
    UserModel? author,
    String? subject,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? content,
    String? imageAsset,
    int? likeCount,
    int? commentCount,
    int? bookmarkCount,
    bool? isLikedByMe,
  }) {
    return PostModel(
      id: id ?? this.id,
      author: author ?? this.author,
      subject: subject ?? this.subject,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      content: content ?? this.content,
      imageAsset: imageAsset ?? this.imageAsset,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      bookmarkCount: bookmarkCount ?? this.bookmarkCount,
      isLikedByMe: isLikedByMe ?? this.isLikedByMe,
    );
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    // Extract author details
    final author = UserModel.fromJson(json['author'] ?? {});
    final id = json['id'] ?? '';

    // Parse createdAt and updatedAt
    final createdAt = json['createdAt'] != null
        ? DateTime.parse(json['createdAt']).toLocal()
        : DateTime.now();
    final updatedAt = json['updatedAt'] != null
        ? DateTime.parse(json['updatedAt']).toLocal()
        : createdAt;

    final stats = json['stats'] ?? {};

    return PostModel(
      id: id,
      author: author,
      subject: json['subject'] ?? 'Post',
      createdAt: createdAt,
      updatedAt: updatedAt,
      content: json['content'] ?? '',
      likeCount: stats['likeCount'] ?? 0,
      commentCount: stats['commentCount'] ?? 0,
      bookmarkCount: stats['bookmarkCount'] ?? 0,
      isLikedByMe: json['isLikedByMe'] ?? false,
    );
  }
}

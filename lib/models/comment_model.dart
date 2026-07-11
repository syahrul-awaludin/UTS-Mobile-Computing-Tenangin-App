import 'user_model.dart';

class CommentModel {
  final String id;
  final String postId;
  final UserModel author;
  final String text;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<CommentModel> replies;

  const CommentModel({
    required this.id,
    required this.postId,
    required this.author,
    required this.text,
    required this.createdAt,
    required this.updatedAt,
    this.replies = const [],
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    final author = UserModel.fromJson(json['author'] ?? {});

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
      author: author,
      text: json['text'] ?? '',
      createdAt: createdAt,
      updatedAt: updatedAt,
      replies: replies,
    );
  }
}

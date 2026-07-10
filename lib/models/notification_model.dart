class NotificationModel {
  final String id;
  final String userId;
  final String senderId;
  final String senderName;
  final String type; // 'LIKE' or 'COMMENT'
  final String postId;
  final String postSubject;
  final bool isRead;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.senderId,
    required this.senderName,
    required this.type,
    required this.postId,
    required this.postSubject,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      senderId: json['senderId'] ?? '',
      senderName: json['sender']?['name'] ?? 'Seseorang',
      type: json['type'] ?? '',
      postId: json['postId'] ?? '',
      postSubject: json['post']?['subject'] ?? 'Post',
      isRead: json['isRead'] ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt']).toLocal()
          : DateTime.now(),
    );
  }
}

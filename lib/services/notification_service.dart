import 'dart:convert';
import 'api_client.dart';
import '../models/notification_model.dart';

class NotificationService {
  Future<List<NotificationModel>> getNotifications() async {
    final response = await ApiClient.get('/notifications');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final List data = jsonResponse['data'] ?? [];
      return data.map((item) => NotificationModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load notifications: ${response.body}');
    }
  }

  Future<void> markAsRead(String id) async {
    final response = await ApiClient.put('/notifications/$id/read');

    if (response.statusCode != 200) {
      throw Exception('Failed to mark notification as read');
    }
  }

  Future<void> markAllAsRead() async {
    final response = await ApiClient.put('/notifications/read-all');

    if (response.statusCode != 200) {
      throw Exception('Failed to mark all notifications as read');
    }
  }
}

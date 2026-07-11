import 'dart:convert';
import 'api_client.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../models/notification_model.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initLocalNotifications() async {
    const initializationSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    // Konfigurasi untuk iOS dan macOS
    const initializationSettingsDarwin = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
    );

    await _notificationsPlugin.initialize(settings: initializationSettings);
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'tenangin_channel',
      'Tenangin Notifications',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    const darwinPlatformChannelSpecifics = DarwinNotificationDetails();

    const platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: darwinPlatformChannelSpecifics,
      macOS: darwinPlatformChannelSpecifics,
    );

    await _notificationsPlugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: platformChannelSpecifics,
    );
  }

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

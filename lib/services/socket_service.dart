import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:overlay_support/overlay_support.dart';
import '../theme/app_colors.dart';
import 'notification_service.dart';

class SocketService with ChangeNotifier {
  io.Socket? _socket;

  // Stream untuk meng-handle update dari socket secara global
  final _postUpdateController =
      StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get onPostUpdated =>
      _postUpdateController.stream;

  // Sambungkan ke server WebSocket
  Future<void> connectAndListen() async {
    if (_socket != null && _socket!.connected) return;

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) return;

    _socket = io.io('https://tenangin.syahrulawaludin.my.id', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'auth': {'token': token},
    });

    _socket!.connect();

    _socket!.onConnect((_) {
      debugPrint('Connected to WebSocket');
    });

    // Mendengarkan event notifikasi dari backend
    _socket!.on('new_notification', (data) {
      debugPrint('Menerima Notifikasi Baru: $data');
      if (data != null) {
        String title = data['title'] ?? 'Notifikasi Baru';
        String body = data['body'] ?? '';

        // Tampilkan notifikasi di status bar (sistem HP)
        NotificationService().showNotification(
          id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
          title: title,
          body: body,
        );

        // Memunculkan In-App Notification Overlay di bagian atas (menggunakan overlay_support)
        showSimpleNotification(
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(body),
          background: AppColors.primary,
          duration: const Duration(seconds: 4),
          slideDismissDirection: DismissDirection.up,
        );
      }
    });

    // Mendengarkan update status postingan (jumlah like/comment)
    _socket!.on('post_updated', (data) {
      debugPrint('Menerima Update Postingan: $data');
      if (data != null) {
        _postUpdateController.add(Map<String, dynamic>.from(data));
      }
    });

    _socket!.onDisconnect((_) => debugPrint('Disconnected from WebSocket'));
  }

  // Putuskan koneksi saat logout
  void disconnect() {
    _socket?.disconnect();
    _socket = null;
  }

  @override
  void dispose() {
    _postUpdateController.close();
    disconnect();
    super.dispose();
  }
}

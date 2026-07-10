import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'notification_service.dart';

class SocketService with ChangeNotifier {
  IO.Socket? _socket;

  // Sambungkan ke server WebSocket
  Future<void> connectAndListen() async {
    if (_socket != null && _socket!.connected) return;

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) return;

    _socket = IO.io('http://103.93.135.88:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'auth': {'token': token}
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
        
        // Memunculkan local notification
        NotificationService().showNotification(
          id: data['id']?.hashCode ?? 0, 
          title: title, 
          body: body
        );
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
    disconnect();
    super.dispose();
  }
}

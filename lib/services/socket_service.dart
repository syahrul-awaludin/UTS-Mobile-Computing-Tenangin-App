import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:overlay_support/overlay_support.dart';

class SocketService with ChangeNotifier {
  io.Socket? _socket;

  // Sambungkan ke server WebSocket
  Future<void> connectAndListen() async {
    if (_socket != null && _socket!.connected) return;

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) return;

    _socket = io.io('https://tenangin.syahrulawaludin.my.id', <String, dynamic>{
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
        
        // Memunculkan In-App Notification Overlay di bagian atas (menggunakan overlay_support)
        showSimpleNotification(
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(body),
          background: const Color(0xFF3B82F6), // AppColors.primary
          duration: const Duration(seconds: 4),
          slideDismissDirection: DismissDirection.up,
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

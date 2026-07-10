import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_client.dart';

class AuthService {
  static const String _baseUrl = 'https://tenangin.syahrulawaludin.my.id/api/v1/auth';

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data;
    } else {
      final message = data['error'] != null ? data['error']['message'] : data['message'] ?? 'Login failed';
      throw Exception(message);
    }
  }

  Future<Map<String, dynamic>> register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 201 || response.statusCode == 200) {
      return data;
    } else {
      final message = data['error'] != null ? data['error']['message'] : data['message'] ?? 'Register failed';
      throw Exception(message);
    }
  }

  Future<Map<String, dynamic>> getMe() async {
    final response = await ApiClient.get('/auth/me');

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data['data'] ?? data;
    } else {
      final message = data['error'] != null ? data['error']['message'] : data['message'] ?? 'Failed to get user profile';
      throw Exception(message);
    }
  }
}

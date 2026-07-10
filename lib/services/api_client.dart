import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  static const String _baseUrl = 'https://tenangin.syahrulawaludin.my.id/api/v1';
  static final http.Client _client = http.Client();

  static Future<http.Response> get(String endpoint) async {
    return _requestWithRetry(() => _client.get(
          Uri.parse('$_baseUrl$endpoint'),
          headers: _getHeaders(null),
        ));
  }

  static Future<http.Response> post(String endpoint, {dynamic body}) async {
    return _requestWithRetry(() => _client.post(
          Uri.parse('$_baseUrl$endpoint'),
          headers: _getHeaders('application/json'),
          body: body != null ? jsonEncode(body) : null,
        ));
  }

  static Future<http.Response> put(String endpoint, {dynamic body}) async {
    return _requestWithRetry(() => _client.put(
          Uri.parse('$_baseUrl$endpoint'),
          headers: _getHeaders('application/json'),
          body: body != null ? jsonEncode(body) : null,
        ));
  }

  static Future<http.Response> delete(String endpoint, {dynamic body}) async {
    return _requestWithRetry(() => _client.delete(
          Uri.parse('$_baseUrl$endpoint'),
          headers: _getHeaders('application/json'),
          body: body != null ? jsonEncode(body) : null,
        ));
  }

  static Future<http.Response> _requestWithRetry(Future<http.Response> Function() request) async {
    await _loadTokens();
    var response = await request();

    if (response.statusCode == 401) {
      bool success = await _refreshToken();
      if (success) {
        // Retry the request with the new token
        response = await request();
      }
    }
    return response;
  }

  static String? _accessToken;
  
  static Future<void> _loadTokens() async {
    final prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString('auth_token');
  }

  static Map<String, String> _getHeaders(String? contentType) {
    final headers = <String, String>{};
    if (contentType != null) {
      headers['Content-Type'] = contentType;
    }
    if (_accessToken != null) {
      headers['Authorization'] = 'Bearer $_accessToken';
    }
    return headers;
  }

  static Future<bool> _refreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString('refresh_token');

    if (refreshToken == null) return false;

    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl/auth/refresh'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'refreshToken': refreshToken}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final newAccessToken = data['accessToken'];
        final newRefreshToken = data['refreshToken'];

        if (newAccessToken != null) {
          _accessToken = newAccessToken;
          await prefs.setString('auth_token', newAccessToken);
        }
        if (newRefreshToken != null) {
          await prefs.setString('refresh_token', newRefreshToken);
        }
        return true;
      } else {
        // If refresh fails, log the user out
        await _forceLogout();
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<void> _forceLogout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('refresh_token');
    await prefs.setBool('is_logged_in', false);
    _accessToken = null;
  }
}

import 'dart:convert';
import 'api_client.dart';

class ProfileService {

  Future<Map<String, dynamic>> fetchUserProfile() async {
    final response = await ApiClient.get('/auth/me');

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // Assuming the API returns the user object directly or nested in a 'data' field
      return data['data'] ?? data;
    } else {
      final message = data['error'] != null ? data['error']['message'] : data['message'] ?? 'Failed to fetch profile';
      throw Exception(message);
    }
  }
}

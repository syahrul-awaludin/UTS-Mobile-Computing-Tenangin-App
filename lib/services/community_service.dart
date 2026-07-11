import 'dart:convert';
import 'api_client.dart';

class CommunityService {
  Future<List<dynamic>> fetchPosts() async {
    final response = await ApiClient.get('/posts');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data'];
    } else {
      throw Exception(
        'Failed to load posts. Status Code: ${response.statusCode}',
      );
    }
  }

  Future<Map<String, dynamic>> createPost(
    String subject,
    String content,
  ) async {
    final response = await ApiClient.post(
      '/posts',
      body: {'subject': subject, 'content': content},
    );

    final data = json.decode(response.body);

    if (response.statusCode == 201 || response.statusCode == 200) {
      return data['data'] ?? data;
    } else {
      final message = data['error'] != null
          ? data['error']['message']
          : data['message'] ?? 'Failed to create post';
      throw Exception(message);
    }
  }

  Future<bool> deletePost(String postId) async {
    final response = await ApiClient.delete('/posts/$postId');

    if (response.statusCode == 200) {
      return true;
    } else {
      final data = json.decode(response.body);
      final message = data['error'] != null
          ? data['error']['message']
          : data['message'] ?? 'Failed to delete post';
      throw Exception(message);
    }
  }

  Future<Map<String, dynamic>> toggleLike(String postId) async {
    final response = await ApiClient.post('/posts/$postId/like');

    final data = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return data['data']; // returns { isLiked: true/false, totalLikes: int }
    } else {
      final message = data['error'] != null
          ? data['error']['message']
          : data['message'] ?? 'Failed to toggle like';
      throw Exception(message);
    }
  }

  Future<List<dynamic>> fetchComments(String postId) async {
    final response = await ApiClient.get('/posts/$postId/comments');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data'];
    } else {
      throw Exception('Failed to load comments');
    }
  }

  Future<Map<String, dynamic>> addComment(
    String postId,
    String text, {
    String? parentId,
  }) async {
    final body = {'text': text};
    if (parentId != null) {
      body['parentId'] = parentId;
    }

    final response = await ApiClient.post(
      '/posts/$postId/comments',
      body: body,
    );

    final data = json.decode(response.body);

    if (response.statusCode == 201 || response.statusCode == 200) {
      return data['data'] ?? data;
    } else {
      final message = data['error'] != null
          ? data['error']['message']
          : data['message'] ?? 'Failed to add comment';
      throw Exception(message);
    }
  }

  Future<Map<String, dynamic>> updatePost(
    String postId,
    String subject,
    String content, {
    String? mood,
  }) async {
    final body = {'subject': subject, 'content': content};
    if (mood != null) {
      body['mood'] = mood;
    }

    final response = await ApiClient.put('/posts/$postId', body: body);

    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      return data['data'] ?? data;
    } else {
      final message = data['error'] != null
          ? data['error']['message']
          : data['message'] ?? 'Failed to update post';
      throw Exception(message);
    }
  }

  Future<bool> deleteComment(String commentId) async {
    final response = await ApiClient.delete('/posts/comments/$commentId');

    if (response.statusCode == 200) {
      return true;
    } else {
      final data = json.decode(response.body);
      final message = data['error'] != null
          ? data['error']['message']
          : data['message'] ?? 'Failed to delete comment';
      throw Exception(message);
    }
  }

  Future<Map<String, dynamic>> updateComment(
    String commentId,
    String text,
  ) async {
    final response = await ApiClient.put(
      '/posts/comments/$commentId',
      body: {'text': text},
    );

    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      return data['data'] ?? data;
    } else {
      final message = data['error'] != null
          ? data['error']['message']
          : data['message'] ?? 'Failed to update comment';
      throw Exception(message);
    }
  }
}

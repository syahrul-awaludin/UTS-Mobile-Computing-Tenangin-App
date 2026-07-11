import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/post_model.dart';
import '../services/community_service.dart';
import '../services/socket_service.dart';

class CommunityController extends ChangeNotifier {
  List<PostModel> _posts = [];
  bool _isLoading = false;
  String? _errorMessage;
  String _filterType = 'terbaru'; // terbaru, terlama, trend

  List<PostModel> get posts => _posts;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get filterType => _filterType;

  final TextEditingController searchController = TextEditingController();
  String _searchQuery = '';

  final TextEditingController postSubjectController = TextEditingController();
  final TextEditingController postContentController = TextEditingController();

  List<PostModel> get filteredPosts {
    List<PostModel> result = _posts;
    if (_searchQuery.isNotEmpty) {
      result = result
          .where(
            (post) =>
                post.subject.toLowerCase().contains(_searchQuery.toLowerCase()),
          )
          .toList();
    }

    // Create a copy to sort
    result = List.from(result);

    if (_filterType == 'terbaru') {
      result.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } else if (_filterType == 'terlama') {
      result.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    } else if (_filterType == 'trend') {
      result.sort((a, b) {
        final scoreA = a.likeCount + a.commentCount;
        final scoreB = b.likeCount + b.commentCount;
        if (scoreB == scoreA) {
          // If scores are equal, sort by newest
          return b.createdAt.compareTo(a.createdAt);
        }
        return scoreB.compareTo(scoreA);
      });
    }

    return result;
  }

  void setFilterType(String type) {
    if (_filterType != type) {
      _filterType = type;
      notifyListeners();
    }
  }

  final CommunityService _communityService;
  final SocketService _socketService;
  late final StreamSubscription<Map<String, dynamic>> _postUpdateSubscription;

  CommunityController(this._communityService, this._socketService) {
    fetchPosts();
    _postUpdateSubscription = _socketService.onPostUpdated.listen(
      _handlePostUpdate,
    );
  }

  void _handlePostUpdate(Map<String, dynamic> data) {
    final postId = data['postId'] as String?;
    if (postId == null) return;

    final index = _posts.indexWhere((p) => p.id == postId);
    if (index != -1) {
      int newLikeCount = _posts[index].likeCount;
      int newCommentCount = _posts[index].commentCount;

      if (data.containsKey('totalLikes')) {
        newLikeCount = data['totalLikes'] as int;
      }
      if (data.containsKey('totalComments')) {
        newCommentCount = data['totalComments'] as int;
      }

      _posts[index] = _posts[index].copyWith(
        likeCount: newLikeCount,
        commentCount: newCommentCount,
      );

      notifyListeners();
    }
  }

  Future<void> fetchPosts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token == null) {
        throw Exception('Please login to view posts');
      }

      final postsJson = await _communityService.fetchPosts();
      _posts = postsJson.map((json) => PostModel.fromJson(json)).toList();
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createPost(BuildContext context) async {
    final subject = postSubjectController.text.trim();
    final content = postContentController.text.trim();

    if (subject.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please write a subject and content!')),
      );
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token == null) {
        throw Exception('Please login to create a post');
      }

      final newPostJson = await _communityService.createPost(subject, content);
      final newPost = PostModel.fromJson(newPostJson);

      _posts.insert(0, newPost);

      // Reset controllers
      postSubjectController.clear();
      postContentController.clear();

      if (context.mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (context.mounted) {
        final errorMessage = e.toString().replaceFirst('Exception: ', '');
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessage)));
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deletePost(String postId, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token == null) {
        throw Exception('Please login to delete a post');
      }

      await _communityService.deletePost(postId);
      _posts.removeWhere((post) => post.id == postId);
      return true;
    } catch (e) {
      if (context.mounted) {
        final errorMessage = e.toString().replaceFirst('Exception: ', '');
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessage)));
      }
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void updateSearch(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<void> toggleLike(String postId, BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      if (token == null) return;

      // Optimistic update
      final postIndex = _posts.indexWhere((p) => p.id == postId);
      if (postIndex != -1) {
        final currentPost = _posts[postIndex];
        final newIsLiked = !currentPost.isLikedByMe;
        final newLikeCount = currentPost.likeCount + (newIsLiked ? 1 : -1);
        _posts[postIndex] = PostModel(
          id: currentPost.id,
          author: currentPost.author,
          subject: currentPost.subject,
          createdAt: currentPost.createdAt,
          updatedAt: currentPost.updatedAt,
          content: currentPost.content,
          imageAsset: currentPost.imageAsset,
          likeCount: newLikeCount,
          commentCount: currentPost.commentCount,
          bookmarkCount: currentPost.bookmarkCount,
          isLikedByMe: newIsLiked,
        );
        notifyListeners();
      }

      final result = await _communityService.toggleLike(postId);

      // Update with exact numbers from server
      if (postIndex != -1) {
        final currentPost = _posts[postIndex];
        _posts[postIndex] = PostModel(
          id: currentPost.id,
          author: currentPost.author,
          subject: currentPost.subject,
          createdAt: currentPost.createdAt,
          updatedAt: currentPost.updatedAt,
          content: currentPost.content,
          imageAsset: currentPost.imageAsset,
          likeCount: result['totalLikes'],
          commentCount: currentPost.commentCount,
          bookmarkCount: currentPost.bookmarkCount,
          isLikedByMe: result['isLiked'],
        );
        notifyListeners();
      }
    } catch (e) {
      if (context.mounted) {
        final errorMessage = e.toString().replaceFirst('Exception: ', '');
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessage)));
      }
      // Revert in case of failure
      fetchPosts();
    }
  }

  Future<List<dynamic>> fetchCommentsForPost(String postId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      if (token == null) throw Exception('Silakan login');

      return await _communityService.fetchComments(postId);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> addCommentToPost(
    String postId,
    String text, {
    String? parentId,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      if (token == null) throw Exception('Silakan login');

      final result = await _communityService.addComment(
        postId,
        text,
        parentId: parentId,
      );

      // Update comment count locally
      final postIndex = _posts.indexWhere((p) => p.id == postId);
      if (postIndex != -1) {
        final currentPost = _posts[postIndex];
        _posts[postIndex] = PostModel(
          id: currentPost.id,
          author: currentPost.author,
          subject: currentPost.subject,
          createdAt: currentPost.createdAt,
          updatedAt: currentPost.updatedAt,
          content: currentPost.content,
          imageAsset: currentPost.imageAsset,
          likeCount: currentPost.likeCount,
          commentCount: currentPost.commentCount + 1,
          bookmarkCount: currentPost.bookmarkCount,
          isLikedByMe: currentPost.isLikedByMe,
        );
        notifyListeners();
      }

      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updatePost(
    String postId,
    String subject,
    String content,
    BuildContext context, {
    String? mood,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      if (token == null) throw Exception('Please login');

      final updatedPostJson = await _communityService.updatePost(
        postId,
        subject,
        content,
        mood: mood,
      );
      final updatedPost = PostModel.fromJson(updatedPostJson);

      final index = _posts.indexWhere((p) => p.id == postId);
      if (index != -1) {
        _posts[index] = PostModel(
          id: updatedPost.id,
          author: updatedPost.author,
          subject: updatedPost.subject,
          createdAt: updatedPost.createdAt,
          updatedAt: updatedPost.updatedAt,
          content: updatedPost.content,
          imageAsset: updatedPost.imageAsset,
          likeCount: updatedPost.likeCount,
          commentCount: updatedPost.commentCount,
          bookmarkCount: updatedPost.bookmarkCount,
          isLikedByMe: _posts[index].isLikedByMe,
        );
      }
      return true;
    } catch (e) {
      if (context.mounted) {
        final errorMessage = e.toString().replaceFirst('Exception: ', '');
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessage)));
      }
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteComment(String commentId, BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      if (token == null) throw Exception('Please login');

      await _communityService.deleteComment(commentId);
      return true;
    } catch (e) {
      if (context.mounted) {
        final errorMessage = e.toString().replaceFirst('Exception: ', '');
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessage)));
      }
      return false;
    }
  }

  Future<bool> updateComment(
    String commentId,
    String text,
    BuildContext context,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      if (token == null) throw Exception('Please login');

      await _communityService.updateComment(commentId, text);
      return true;
    } catch (e) {
      if (context.mounted) {
        final errorMessage = e.toString().replaceFirst('Exception: ', '');
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessage)));
      }
      return false;
    }
  }

  @override
  void dispose() {
    _postUpdateSubscription.cancel();
    searchController.dispose();
    postSubjectController.dispose();
    postContentController.dispose();
    super.dispose();
  }
}

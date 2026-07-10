import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_colors.dart';
import '../../models/post_model.dart';
import '../../models/comment_model.dart';
import '../../controllers/community_controller.dart';
import '../../widgets/cards/post_card.dart';
import '../../widgets/community/comment_item.dart';
import '../../widgets/community/comment_input.dart';

class PostDetailView extends StatefulWidget {
  final PostModel post;
  final String? currentUserId;

  const PostDetailView({super.key, required this.post, this.currentUserId});

  @override
  State<PostDetailView> createState() => _PostDetailViewState();
}

class _PostDetailViewState extends State<PostDetailView> {
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  
  List<CommentModel> _comments = [];
  bool _isLoading = true;
  String? _errorMessage;
  CommentModel? _replyingTo;

  @override
  void initState() {
    super.initState();
    _fetchComments();
  }

  Future<void> _fetchComments() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final controller = context.read<CommunityController>();
      final data = await controller.fetchCommentsForPost(widget.post.id);
      if (mounted) {
        setState(() {
          _comments = data.map((json) => CommentModel.fromJson(json)).toList();
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString().replaceFirst('Exception: ', '');
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _submitComment() async {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;

    final controller = context.read<CommunityController>();
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => const Center(child: CircularProgressIndicator()),
      );
      
      final parentId = _replyingTo?.id;
      await controller.addCommentToPost(widget.post.id, text, parentId: parentId);
      
      if (mounted) {
        Navigator.pop(context); // close loading
        _commentController.clear();
        setState(() {
          _replyingTo = null;
        });
        _focusNode.unfocus();
        await _fetchComments();
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context); // close loading
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString().replaceFirst('Exception: ', ''))),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Post', style: TextStyle(fontFamily: 'Inter', color: AppColors.textHeading, fontSize: 18, fontWeight: FontWeight.w600)),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textHeading),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.borderDefault, height: 1),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: _fetchComments,
              color: AppColors.primary,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  PostCard(post: widget.post, currentUserId: widget.currentUserId, isDetail: true),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Comments', style: TextStyle(fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textHeading)),
                        const SizedBox(height: 16),
                        if (_isLoading)
                          const Center(child: Padding(padding: EdgeInsets.all(20), child: CircularProgressIndicator()))
                        else if (_errorMessage != null)
                          Center(child: Text(_errorMessage!, style: const TextStyle(color: AppColors.moodStress)))
                        else if (_comments.isEmpty)
                          const Center(child: Padding(padding: EdgeInsets.all(20), child: Text('No comments yet', style: TextStyle(color: AppColors.textCaption))))
                        else
                          ..._comments.map((comment) => CommentItem(
                            comment: comment,
                            currentUserId: widget.currentUserId,
                            onReply: (replyTo) {
                              setState(() {
                                _replyingTo = replyTo;
                              });
                              _focusNode.requestFocus();
                            },
                            onRefresh: _fetchComments,
                          )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          CommentInput(
            replyingTo: _replyingTo,
            controller: _commentController,
            focusNode: _focusNode,
            onSubmit: _submitComment,
            onCancelReply: () => setState(() => _replyingTo = null),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}

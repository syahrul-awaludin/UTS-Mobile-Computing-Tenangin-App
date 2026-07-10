import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/notification_controller.dart';
import '../../controllers/community_controller.dart';
import '../../theme/app_colors.dart';
import '../../widgets/notification/notification_item.dart';
import '../community/post_detail_view.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotificationController>().loadNotifications();
    });
  }

  void _navigateToPost(String postId, String notificationId) async {
    // Tandai sebagai dibaca
    context.read<NotificationController>().markAsRead(notificationId);

    // Buka detail post
    final communityController = context.read<CommunityController>();
    final index = communityController.posts.indexWhere((p) => p.id == postId);
    if (index != -1) {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PostDetailView(post: communityController.posts[index])),
      );
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Post may have been deleted.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textHeading,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          TextButton(
            onPressed: () {
              context.read<NotificationController>().markAllAsRead();
            },
            child: const Text(
              'Mark all',
              style: TextStyle(color: AppColors.primary, fontSize: 13),
            ),
          ),
        ],
      ),
      body: Consumer<NotificationController>(
        builder: (context, controller, _) {
          if (controller.isLoading && controller.notifications.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.error != null && controller.notifications.isEmpty) {
            return Center(child: Text('Error: ${controller.error}'));
          }
          if (controller.notifications.isEmpty) {
            return const Center(
              child: Text(
                'No notifications yet.',
                style: TextStyle(color: AppColors.textCaption, fontSize: 16),
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () => controller.loadNotifications(),
            child: ListView.separated(
              itemCount: controller.notifications.length,
              separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFF3F4F6)),
              itemBuilder: (context, index) {
                final notification = controller.notifications[index];
                return NotificationItem(
                  notification: notification,
                  onTap: () => _navigateToPost(notification.postId, notification.id),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

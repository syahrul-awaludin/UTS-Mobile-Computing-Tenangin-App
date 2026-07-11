import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chewie/chewie.dart';
import '../../controllers/video_detail_controller.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';

class VideoDetailView extends StatelessWidget {
  final String title;
  final String videoId;

  const VideoDetailView({
    super.key,
    this.title = 'Taking Out of Stress',
    this.videoId = 'dQw4w9WgXcQ',
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VideoDetailController()..initializePlayer(videoId),
      child: _VideoDetailContent(title: title),
    );
  }
}

class _VideoDetailContent extends StatelessWidget {
  final String title;
  const _VideoDetailContent({required this.title});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<VideoDetailController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textHeading),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColors.textHeading),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildVideoPlayer(controller),
            const SizedBox(height: 24),
            _buildVideoInfo(controller, title),
            const SizedBox(height: 32),
            _buildTeacherInfo(controller),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoPlayer(VideoDetailController controller) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          color: Colors.black,
          child: controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : controller.errorMessage != null
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Error: ${controller.errorMessage}',
                          style: AppTypography.body1Regular(color: Colors.white),
                        ),
                      ),
                    )
                  : Chewie(controller: controller.chewieController!),
        ),
      ),
    );
  }

  Widget _buildVideoInfo(VideoDetailController controller, String fallbackTitle) {
    final displayTitle = controller.videoTitle ?? fallbackTitle;
    final displayDescription = (controller.videoDescription != null && controller.videoDescription!.isNotEmpty)
        ? (controller.videoDescription!.length > 150
            ? '${controller.videoDescription!.substring(0, 150)}...'
            : controller.videoDescription!)
        : 'Bring a sense of spaciousness into your day\nwith a quick breathing exercise.';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                displayTitle,
                style: AppTypography.headlineH3SemiBold(),
              ),
              const SizedBox(height: 8),
              Text(
                displayDescription,
                style: AppTypography.body2Regular(color: AppColors.textCaption),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        const Icon(Icons.favorite_border, color: AppColors.textHeading, size: 28),
      ],
    );
  }

  Widget _buildTeacherInfo(VideoDetailController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Teacher',
          style: AppTypography.titleSemiBold(),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFE082),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text('👩🏼', style: TextStyle(fontSize: 24)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  controller.videoAuthor ?? 'Michelle Jane',
                  style: AppTypography.body1Medium(),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

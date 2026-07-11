import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chewie/chewie.dart';
import '../../controllers/video_detail_controller.dart';
import '../../theme/app_colors.dart';

class VideoDetailView extends StatelessWidget {
  final String videoId;
  final String fallbackTitle;

  const VideoDetailView({
    super.key,
    this.videoId = 'dQw4w9WgXcQ',
    this.fallbackTitle = 'Taking Out of Stress',
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VideoDetailController()..initializePlayer(videoId),
      child: const _VideoDetailContent(),
    );
  }
}

class _VideoDetailContent extends StatefulWidget {
  const _VideoDetailContent();

  @override
  State<_VideoDetailContent> createState() => _VideoDetailContentState();
}

class _VideoDetailContentState extends State<_VideoDetailContent> {
  bool _isExpanded = false;

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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // VIDEO PLAYER SECTION
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(24),
              ),
              clipBehavior: Clip.hardEdge,
              child: controller.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    )
                  : controller.errorMessage != null
                  ? Center(
                      child: Text(
                        controller.errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    )
                  : controller.chewieController != null
                  ? Chewie(controller: controller.chewieController!)
                  : const SizedBox(),
            ),
            const SizedBox(height: 24),

            // TITLE AND FAVORITE ICON
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: controller.isLoading
                      ? _buildSkeletonText(height: 24, width: double.infinity)
                      : Text(
                          controller.videoTitle ?? 'Video Title',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textHeading,
                            fontFamily: 'Inter',
                          ),
                        ),
                ),
                const SizedBox(width: 16),
                const Icon(
                  Icons.favorite_border,
                  color: AppColors.textHeading,
                  size: 28,
                ),
              ],
            ),
            const SizedBox(height: 12),

            // DESCRIPTION
            controller.isLoading
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSkeletonText(height: 14, width: double.infinity),
                      const SizedBox(height: 6),
                      _buildSkeletonText(height: 14, width: double.infinity),
                      const SizedBox(height: 6),
                      _buildSkeletonText(
                        height: 14,
                        width: MediaQuery.of(context).size.width * 0.6,
                      ),
                    ],
                  )
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.videoDescription ??
                              'No description available.',
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textCaption,
                            height: 1.4,
                          ),
                          maxLines: _isExpanded ? null : 3,
                          overflow: _isExpanded
                              ? TextOverflow.visible
                              : TextOverflow.ellipsis,
                        ),
                        if ((controller.videoDescription ?? '').length > 100)
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              _isExpanded
                                  ? 'Sembunyikan'
                                  : 'Baca selanjutnya...',
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
            const SizedBox(height: 32),

            // TEACHER / AUTHOR
            const Text(
              'Channel',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textHeading,
              ),
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
                      child: Text('🎥', style: TextStyle(fontSize: 24)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: controller.isLoading
                        ? _buildSkeletonText(height: 18, width: 120)
                        : Text(
                            controller.videoAuthor ?? 'Creator',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textHeading,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSkeletonText({required double height, required double width}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: AppColors.primaryDeep.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

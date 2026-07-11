import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/community_controller.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../widgets/community/community_content.dart';
import '../../widgets/community/filter_drawer.dart';
import '../../widgets/common/app_search_bar.dart';
import '../../widgets/notification/notification_badge.dart';
import 'add_post_view.dart';

class CommunityView extends StatelessWidget {
  const CommunityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Community',
          style: AppTypography.headlineH1Bold(),
        ),
        actions: [
          const NotificationBadge(),
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.filter_list, color: AppColors.textHeading),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
        centerTitle: false,
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      endDrawer: const FilterDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Builder(
              builder: (context) {
                final controller = context.read<CommunityController>();
                return AppSearchBar(
                  controller: controller.searchController,
                  hintText: 'Search discussions or topics...',
                  onChanged: (val) {
                    controller.updateSearch(val);
                  },
                );
              }
            ),
          ),
          const Expanded(
            child: CommunityContent(),
          ),
        ],
      ),
      floatingActionButton: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF9B7EF8), Color(0xFF7B5CE8)],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddPostView()),
            );
          },
          child: const Icon(Icons.add, color: Colors.white, size: 28),
        ),
      ),
    );
  }

}

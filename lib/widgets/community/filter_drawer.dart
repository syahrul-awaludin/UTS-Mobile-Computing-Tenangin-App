import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/community_controller.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';

class FilterDrawer extends StatelessWidget {
  const FilterDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Consumer<CommunityController>(
          builder: (context, controller, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Filter Posts',
                    style: AppTypography.titleSemiBold(),
                  ),
                ),
                const Divider(height: 1, color: AppColors.borderDefault),
                _buildFilterItem(
                  context,
                  controller,
                  title: 'Trending (Most Popular)',
                  icon: Icons.local_fire_department,
                  value: 'trend',
                ),
                _buildFilterItem(
                  context,
                  controller,
                  title: 'Newest',
                  icon: Icons.access_time,
                  value: 'terbaru',
                ),
                _buildFilterItem(
                  context,
                  controller,
                  title: 'Oldest',
                  icon: Icons.history,
                  value: 'terlama',
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildFilterItem(
    BuildContext context,
    CommunityController controller, {
    required String title,
    required IconData icon,
    required String value,
  }) {
    final isSelected = controller.filterType == value;
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? AppColors.primary : AppColors.textCaption,
      ),
      title: Text(
        title,
        style: isSelected
            ? AppTypography.body1SemiBold(color: AppColors.primary)
            : AppTypography.body1Regular(color: AppColors.textHeading),
      ),
      trailing: isSelected
          ? const Icon(Icons.check, color: AppColors.primary)
          : null,
      onTap: () {
        controller.setFilterType(value);
        Navigator.pop(context);
      },
    );
  }
}

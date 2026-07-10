import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/community_controller.dart';
import '../../theme/app_colors.dart';

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
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'Filter Posts',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textHeading,
                    ),
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
      leading: Icon(icon, color: isSelected ? AppColors.primary : AppColors.textCaption),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Inter',
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? AppColors.primary : AppColors.textHeading,
        ),
      ),
      trailing: isSelected ? const Icon(Icons.check, color: AppColors.primary) : null,
      onTap: () {
        controller.setFilterType(value);
        Navigator.pop(context);
      },
    );
  }
}

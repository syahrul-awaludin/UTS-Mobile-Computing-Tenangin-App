import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

/// Horizontal date selector used in the Home screen
class DateSelector extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDateSelected;

  const DateSelector({
    super.key,
    required this.selectedIndex,
    required this.onDateSelected,
  });

  static const _days = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 30,
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          final dayName = _days[index % 7];
          final dateNumber = (index + 1).toString();

          return GestureDetector(
            onTap: () => onDateSelected(index),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Text(
                    dayName,
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected
                          ? AppColors.textHeading
                          : AppColors.textCaption,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected ? AppColors.primary : Colors.white,
                      border: isSelected
                          ? null
                          : Border.all(color: AppColors.borderDefault),
                    ),
                    child: Center(
                      child: Text(
                        dateNumber,
                        style: TextStyle(
                          fontSize: 14,
                          color: isSelected
                              ? Colors.white
                              : AppColors.textHeading,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

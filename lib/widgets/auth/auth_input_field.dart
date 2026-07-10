import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class AuthInputField extends StatelessWidget {
  final TextEditingController? controller;
  final IconData icon;
  final String hint;
  final bool obscure;
  final Widget? trailing;

  const AuthInputField({
    super.key,
    this.controller,
    required this.icon,
    required this.hint,
    required this.obscure,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: AppColors.borderDefault),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Icon(icon, color: AppColors.textCaption),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscure,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: const TextStyle(
                    color: AppColors.textCaption, fontSize: 14),
              ),
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}

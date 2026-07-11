import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class AuthInputField extends StatefulWidget {
  final TextEditingController? controller;
  final IconData icon;
  final String hint;
  final bool obscure;
  final Widget? trailing;
  final ValueChanged<String>? onChanged;

  const AuthInputField({
    super.key,
    this.controller,
    required this.icon,
    required this.hint,
    required this.obscure,
    this.trailing,
    this.onChanged,
  });

  @override
  State<AuthInputField> createState() => _AuthInputFieldState();
}

class _AuthInputFieldState extends State<AuthInputField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color: _isFocused ? AppColors.primary : AppColors.borderDefault,
          width: _isFocused ? 1.5 : 1.0,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Icon(
            widget.icon, 
            color: _isFocused ? AppColors.primary : AppColors.textCaption,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              focusNode: _focusNode,
              controller: widget.controller,
              obscureText: widget.obscure,
              onChanged: widget.onChanged,
              decoration: InputDecoration(
                filled: false,
                hoverColor: Colors.transparent,
                focusColor: Colors.transparent,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: widget.hint,
                hintStyle: const TextStyle(
                    color: AppColors.textCaption, fontSize: 14),
              ),
            ),
          ),
          if (widget.trailing != null) widget.trailing!,
        ],
      ),
    );
  }
}

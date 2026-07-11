import 'package:flutter/material.dart';

class UserModel {
  final String id;
  final String name;
  final Color avatarColor;
  final IconData avatarIcon;

  const UserModel({
    required this.id,
    required this.name,
    required this.avatarColor,
    this.avatarIcon = Icons.person,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'] ?? '';
    final name = json['name'] ?? 'Anonymous';

    // Generate a pseudo-random color based on user name length for consistency
    final colors = [
      const Color(0xFFB8E6D0),
      const Color(0xFFF5D0E0),
      const Color(0xFFD4C5F9),
      const Color(0xFFFFE0B2),
      const Color(0xFFE1F5FE),
    ];
    final Color avatarColor = colors[name.length % colors.length];

    return UserModel(
      id: id,
      name: name,
      avatarColor: avatarColor,
      avatarIcon: Icons.person,
    );
  }
}

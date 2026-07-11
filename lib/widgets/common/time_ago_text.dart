import 'dart:async';
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class TimeAgoText extends StatefulWidget {
  final DateTime createdAt;
  final TextStyle? style;

  const TimeAgoText({super.key, required this.createdAt, this.style});

  @override
  State<TimeAgoText> createState() => _TimeAgoTextState();
}

class _TimeAgoTextState extends State<TimeAgoText> {
  late Timer _timer;
  String _timeAgo = '';

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      _updateTime();
    });
  }

  @override
  void didUpdateWidget(covariant TimeAgoText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.createdAt != oldWidget.createdAt) {
      _updateTime();
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateTime() {
    final difference = DateTime.now().difference(widget.createdAt);
    String newTimeAgo = '';
    if (difference.inDays > 0) {
      newTimeAgo = '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      newTimeAgo = '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      newTimeAgo = '${difference.inMinutes}m ago';
    } else {
      newTimeAgo = 'Just now';
    }

    if (newTimeAgo != _timeAgo) {
      if (mounted) {
        setState(() {
          _timeAgo = newTimeAgo;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _timeAgo,
      style:
          widget.style ??
          const TextStyle(
            fontFamily: 'Inter',
            fontSize: 12,
            color: AppColors.textCaption,
          ),
    );
  }
}

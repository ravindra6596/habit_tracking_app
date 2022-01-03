import 'dart:math';

import 'package:flutter/material.dart';
import 'package:habit_tracking_app/ui/theming/app_theme.dart';

class TaskCompletionRing extends StatelessWidget {
  const TaskCompletionRing({
    Key? key,
    required this.progress,
  }) : super(key: key);
  final double progress;
  @override
  Widget build(BuildContext context) {
    final themeData = AppTheme.of(context);
    return AspectRatio(
      aspectRatio: 1.0,
      child: CustomPaint(
        painter: RingPainter(
          progress: progress,
          taskCompletedColor: themeData.accent,
          taskNotCompletedColor: themeData.taskRing,
        ),
      ),
    );
  }
}

class RingPainter extends CustomPainter {
  RingPainter({
    required this.progress,
    required this.taskCompletedColor,
    required this.taskNotCompletedColor,
  });
  final double progress;
  final Color taskCompletedColor;
  final Color taskNotCompletedColor;

  @override
  void paint(Canvas canvas, Size size) {
    final notCompleted = progress < 1.0;
    final strockWidth = size.width / 15;
    final center = Offset(size.width / 2, size.height / 2);
    final radius =notCompleted? (size.width - strockWidth) / 2:size.width/2;

    //for bg circle
    if (notCompleted) {
      final backgroundPaint = Paint()
        ..isAntiAlias = true
        ..strokeWidth = strockWidth
        ..color = taskNotCompletedColor
        ..style = PaintingStyle.stroke;
      canvas.drawCircle(center, radius, backgroundPaint);
    }
    // for foreground circle
    final foregroundPaint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = strockWidth
      ..color = taskCompletedColor
      ..style = notCompleted ? PaintingStyle.stroke : PaintingStyle.fill;
    canvas.drawArc(
      Rect.fromCircle(
        center: center,
        radius: radius,
      ),
      -pi / 2,
      2 * pi * progress,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(covariant RingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

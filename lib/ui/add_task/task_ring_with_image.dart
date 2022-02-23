import 'package:flutter/material.dart';
import 'package:habit_tracking_app/ui/common_widgets/centered_svg_icon.dart';
import 'package:habit_tracking_app/ui/task/task_completion_ring.dart';
import 'package:habit_tracking_app/ui/theming/app_theme.dart';

class TaskRingWithImage extends StatelessWidget {
  const TaskRingWithImage({Key? key, required this.iconName}) : super(key: key);
  final String iconName;

  @override
  Widget build(BuildContext context) {
    final themeData = AppTheme.of(context);
    return Stack(
      children: [
        const TaskCompletionRing(progress: 0),
        Positioned.fill(
          child: CenteredSvgIcon(
            iconName: iconName,
            color: themeData.taskIcon,
          ),
        ),
      ],
    );
  }
}

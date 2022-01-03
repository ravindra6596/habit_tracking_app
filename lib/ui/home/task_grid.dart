import 'dart:math';

import 'package:flutter/material.dart';
import 'package:habit_tracking_app/models/task_preset.dart';
import 'package:habit_tracking_app/ui/tasks/task_with_name.dart';

class TaskGrid extends StatelessWidget {
  const TaskGrid({
    Key? key,
    required this.tasks,
  }) : super(key: key);
  final List<TaskPreset> tasks;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final crossAxisSpacing = constraints.maxWidth * 0.05;
      final taskWidth = (constraints.maxWidth - crossAxisSpacing) / 2.0;
      const aspectRatio = 0.82;
      final taskHeight = taskWidth / aspectRatio;
      final mainAxisSpacing =
          max((constraints.maxHeight - taskHeight * 3.2) / 2.0, 0.1);
      final taskLength = tasks.length;
      return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: crossAxisSpacing,
          mainAxisSpacing: mainAxisSpacing,
          childAspectRatio: 0.8,
        ),
        itemCount: taskLength,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return TaskWithName(task: task);
        },
      );
    });
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracking_app/constants/app_colors.dart';
import 'package:habit_tracking_app/models/front_or_back_side.dart';
import 'package:habit_tracking_app/models/task.dart';
import 'package:habit_tracking_app/ui/add_task/add_task_navigator.dart';
import 'package:habit_tracking_app/ui/add_task/task_details_page.dart';
import 'package:habit_tracking_app/ui/animations/custom_fade_transition.dart';
import 'package:habit_tracking_app/ui/animations/staggered_scale_transition.dart';
import 'package:habit_tracking_app/ui/common_widgets/edit_task_button.dart';
import 'package:habit_tracking_app/ui/task/add_task_item.dart';
import 'package:habit_tracking_app/ui/task/task_with_name_loader.dart';
import 'package:habit_tracking_app/ui/theming/app_theme.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class TasksGrid extends StatefulWidget {
  const TasksGrid({Key? key, required this.tasks, this.onAddOrEditTask})
      : super(key: key);
  final List<Task> tasks;
  final VoidCallback? onAddOrEditTask;

  @override
  TasksGridState createState() => TasksGridState();
}

class TasksGridState extends State<TasksGrid>
    with SingleTickerProviderStateMixin {
  late final animationController =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 300));

  bool _isEditing = false;

  void enterEditMode() {
    animationController.forward();
    setState(() => _isEditing = true);
  }

  void exitEditMode() {
    animationController.reverse();
    setState(() => _isEditing = false);
  }

  Future<void> _addNewTask(WidgetRef ref) async {
   widget.onAddOrEditTask?.call();
    await Future.delayed(const Duration(milliseconds: 200),);
    final appThemeData = AppTheme.of(context);
    final frontOrBackSide = ref.read<FrontOrBackSide>(frontOrBackSideProvider);
    await showCupertinoModalBottomSheet<void>(
      context: context,
      barrierColor: AppColors.black50,
      builder: (_) => AppTheme(
        data: appThemeData,
        child: AddTaskNavigator(frontOrBackSide: frontOrBackSide),
      ),
    );
  }

  Future<void> _editTask(WidgetRef ref, Task task) async {
    widget.onAddOrEditTask?.call();
    await Future.delayed(const Duration(milliseconds: 200));
    final appThemeData = AppTheme.of(context);
    final frontOrBackSide = ref.read<FrontOrBackSide>(frontOrBackSideProvider);
    await showCupertinoModalBottomSheet<void>(
      context: context,
      barrierColor: AppColors.black50,
      builder: (_) => AppTheme(
        data: appThemeData,
        child: TaskDetailsPage(
          task: task,
          isNewTask: false,
          frontOrBackSide: frontOrBackSide,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisSpacing = constraints.maxWidth * 0.05;
        final taskWidth = (constraints.maxWidth - crossAxisSpacing) / 2.0;
        const aspectRatio = 0.82;
        final taskHeight = taskWidth / aspectRatio;
        final mainAxisSpacing =
            max((constraints.maxHeight - taskHeight * 3) / 2.0, 0.1);
        final tasksLength = min(6, widget.tasks.length + 1);
        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: crossAxisSpacing,
            mainAxisSpacing: mainAxisSpacing,
            childAspectRatio: aspectRatio,
          ),
          itemBuilder: (context, index) {
            return Consumer(builder: (context, ref, _) {
              if (index == widget.tasks.length) {
                return CustomFadeTransition(
                  animation: animationController,
                  child: AddTaskItem(
                    onCompleted: _isEditing ? () => _addNewTask(ref) : null,
                  ),
                );
              }
              final task = widget.tasks[index];
              return TaskWithNameLoader(
                task: task,
                isEditing: _isEditing,
                editTaskButtonBuilder: (_) => StaggeredScaleTransition(
                  animation: animationController,
                  index: index,
                  child: EditTaskButton(
                    onPressed: () => _editTask(ref, task),
                  ),
                ),
              );
            });
          },
          itemCount: tasksLength,
        );
      },
    );
  }
}

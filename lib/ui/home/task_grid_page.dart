import 'package:flutter/material.dart';
import 'package:habit_tracking_app/models/task.dart';
import 'package:habit_tracking_app/ui/home/home_page_bottom_option.dart';
import 'package:habit_tracking_app/ui/home/task_grid.dart';
import 'package:habit_tracking_app/ui/theming/app_theme.dart';

class TaskGridPage extends StatelessWidget {
  const TaskGridPage({
    Key? key,
    required this.tasks,
    required this.onFlip,
  }) : super(key: key);
  final List<Task> tasks;
  final VoidCallback onFlip;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.of(context).primary,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: TaskGridContents(
                tasks: tasks,
                 
              ),
            ),
            HomePageBottomOption(onFlip: onFlip,),
          ],
        ),
       
    ),);
  }
}

class TaskGridContents extends StatelessWidget {
  const TaskGridContents({
    Key? key,
    required this.tasks,
   }) : super(key: key);
  final List<Task> tasks;
   @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 16,
      ),
      child: TaskGrid(
        tasks: tasks,
      ),
    );
  }
}

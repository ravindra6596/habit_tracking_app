import 'package:flutter/material.dart';

import '../../models/front_or_back_side.dart';
import '../../models/task.dart';
import '../../models/task_preset.dart';
import 'add_task_page.dart';
import 'task_details_page.dart';

// * The "add task" flow is composed by these two pages
class AddTaskRoutes {
  static const root = '/';
  static const confirmTask = '/confirmTask';
}

class AddTaskNavigator extends StatelessWidget {
  const AddTaskNavigator({Key? key, required this.frontOrBackSide,})
      : super(key: key);
  final FrontOrBackSide frontOrBackSide;

  @override
  Widget build(BuildContext context) {
    // * Using a nested navigator to show the `AddTaskPage` and `TaskDetailsPage`
    // * widgets inside the same navigation stack within `showCupertinoModalBottomSheet`
    return Navigator(
      initialRoute: AddTaskRoutes.root,
      onGenerateRoute: (routeSettings) => MaterialPageRoute(
        builder: (context) {
          switch (routeSettings.name) {
            case AddTaskRoutes.root:
              return const AddTaskPage();
            case AddTaskRoutes.confirmTask:
              final taskPreset = routeSettings.arguments as TaskPreset;
              final task = Task.create(
                name: taskPreset.name,
                iconName: taskPreset.iconName,
              );
              return TaskDetailsPage(
                task: task,
                isNewTask: true,
                frontOrBackSide: frontOrBackSide,
              );
            default:
              throw UnimplementedError();
          }
        },
      ),
    );
  }
}

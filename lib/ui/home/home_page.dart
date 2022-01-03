import 'package:flutter/material.dart';
import 'package:habit_tracking_app/constants/app_assets.dart';
import 'package:habit_tracking_app/models/task_preset.dart';
import 'package:habit_tracking_app/ui/home/task_grid.dart';
import 'package:habit_tracking_app/ui/tasks/animeted_task.dart';
import 'package:habit_tracking_app/ui/tasks/task_with_name.dart';
import 'package:habit_tracking_app/ui/theming/app_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.of(context).primary,
      body: const Padding(
        padding:  EdgeInsets.symmetric(horizontal:24.0,vertical: 16,),
        child:   TaskGrid(tasks: [
          TaskPreset(name: 'Eat a Healthy Meal', iconName: AppAssets.carrot),
          TaskPreset(name: 'Walk the Dog', iconName: AppAssets.dog),
          TaskPreset(name: 'Do Some Coding', iconName: AppAssets.html),
          TaskPreset(name: 'Meditate', iconName: AppAssets.meditation),
          TaskPreset(name: 'Do 10 Pushups', iconName: AppAssets.pushups),
          TaskPreset(name: 'Sleep 8 Hours', iconName: AppAssets.rest),
        ],),
      ),
    );
  }
}

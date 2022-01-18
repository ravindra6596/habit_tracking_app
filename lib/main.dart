import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracking_app/constants/app_colors.dart';
import 'package:habit_tracking_app/models/task.dart';
import 'package:habit_tracking_app/persistance/hive_data_store.dart';
import 'package:habit_tracking_app/ui/theming/app_theme.dart';

import 'constants/app_assets.dart';
import 'ui/home/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppAssets.preloadSVGs();
  final dataStore = HiveDataStore();
  await dataStore.init();
  await dataStore.createDemoTasks(
    frontTasks: [
      Task.create(name: 'Take Vitamins', iconName: AppAssets.vitamins),
      Task.create(name: 'Cycle to Work', iconName: AppAssets.bike),
      Task.create(name: 'Wash Your Hands', iconName: AppAssets.washHands),
      Task.create(name: 'Wear a Mask', iconName: AppAssets.mask),
      Task.create(name: 'Brush Your Teeth', iconName: AppAssets.toothbrush),
      Task.create(name: 'Floss Your Teeth', iconName: AppAssets.dentalFloss),
    ],
    backTasks: [
      Task.create(name: 'Eat a Healthy Meal', iconName: AppAssets.carrot),
      Task.create(name: 'Walk the Dog', iconName: AppAssets.dog),
      Task.create(name: 'Do Some Coding', iconName: AppAssets.html),
      Task.create(name: 'Meditate', iconName: AppAssets.meditation),
      Task.create(name: 'Do 10 Pushups', iconName: AppAssets.pushups),
      Task.create(name: 'Sleep 8 Hours', iconName: AppAssets.rest),
    ],
    force: false,
  );
  runApp(
      ProviderScope(
      overrides: [
        dataStoreProvider.overrideWithValue(dataStore),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Helvetica Neue',
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      home: AppTheme(
          data: AppThemeData.defaultWithSwatch(
            AppColors.red,
          ),
          child:   HomePage()),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracking_app/models/task.dart';
import 'package:habit_tracking_app/persistance/hive_data_store.dart';
import 'package:habit_tracking_app/ui/home/task_grid_page.dart';
import 'package:hive/hive.dart';
import 'package:page_flip_builder/page_flip_builder.dart';

class HomePage extends StatefulWidget {
 const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pageFlipKey = GlobalKey<PageFlipBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, ref, __) {
final dataStore = ref.watch(dataStoreProvider);
      return PageFlipBuilder(
        key: pageFlipKey,
        frontBuilder: (_) => ValueListenableBuilder(
          valueListenable: dataStore.frontTaskListanable(),
          builder: (_, Box<Task> box, __) => TaskGridPage(
            key: const ValueKey(1),
            tasks: box.values.toList(),
            onFlip: () => pageFlipKey.currentState!.flip(),
          ),
        ),
        backBuilder: (_) => ValueListenableBuilder(
          valueListenable: dataStore.backTaskListanable(),
          builder: (_, Box<Task> box, __) => TaskGridPage(
            key: const ValueKey(2),
            tasks: box.values.toList(),
            onFlip: () => pageFlipKey.currentState!.flip(),
          ),
        ),
      );

    });
    
    /* TaskGrid(
          tasks: [
            TaskPreset(name: 'Eat a Healthy Meal', iconName: AppAssets.carrot),
            TaskPreset(name: 'Walk the Dog', iconName: AppAssets.dog),
            TaskPreset(name: 'Do Some Coding', iconName: AppAssets.html),
            TaskPreset(name: 'Meditate', iconName: AppAssets.meditation),
            TaskPreset(name: 'Do 10 Pushups', iconName: AppAssets.pushups),
            TaskPreset(name: 'Sleep 8 Hours', iconName: AppAssets.rest),
          ],
        ), */
  }
}

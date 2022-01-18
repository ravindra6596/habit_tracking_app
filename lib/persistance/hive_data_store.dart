import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracking_app/models/task.dart';
import 'package:habit_tracking_app/models/task_state.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDataStore {
  static const frontTasksBoxName = 'frontTasks';
  static const backTasksBoxName = 'backTasks';
  static const tasksStateBoxName = 'tasksState';
  static String taskStateKey(String key) => 'tasksState/$key';
  Future<void> init() async {
    await Hive.initFlutter();
    // register adapter
    Hive.registerAdapter<Task>(
      TaskAdapter(),
    );
    Hive.registerAdapter<TaskState>(
      TaskStateAdapter(),
    );
    // open boxes
    await Hive.openBox<Task>(frontTasksBoxName);
    await Hive.openBox<Task>(backTasksBoxName);
    await Hive.openBox<Task>(tasksStateBoxName);
  }

  Future<void> createDemoTasks({
    required List<Task> frontTasks,
    required List<Task> backTasks,
    bool force = false,
  }) async {
    final frontBox = Hive.box<Task>(frontTasksBoxName);
    if (frontBox.isEmpty || force==true) {
      await frontBox.clear();
      await frontBox.addAll(frontTasks);
    } else {
      if (kDebugMode) {
        print('Box already has ${frontBox.length} items');
      }
    }
    final backBox = Hive.box<Task>(backTasksBoxName);
    if (backBox.isEmpty || force==true) {
      await backBox.clear();
      await backBox.addAll(backTasks);
    } else {
      if (kDebugMode) {
        print('Box already has ${backBox.length} items');
      }
    }
  }

  ValueListenable<Box<Task>> frontTaskListanable() {
    return Hive.box<Task>(frontTasksBoxName).listenable();
  }
  ValueListenable<Box<Task>> backTaskListanable() {
    return Hive.box<Task>(backTasksBoxName).listenable();
  }

  Future<void> setTaskState({
    required Task task,
    required bool completed,
  }) async {
    final box = Hive.box<TaskState>(tasksStateBoxName);
    final taskState = TaskState(
      taskId: task.id,
      completed: completed,
    );
    await box.put(
      taskStateKey(task.id),
      taskState,
    );
  }
//62
  ValueListenable<Box<TaskState>> taskStateListanable({required Task task}) {
    final box = Hive.box<TaskState>(tasksStateBoxName);
    final key = taskStateKey(task.id);
    return box.listenable(keys: <String>[key]);
  }
}

final dataStoreProvider = Provider<HiveDataStore>((ref) {
  throw UnimplementedError();
});

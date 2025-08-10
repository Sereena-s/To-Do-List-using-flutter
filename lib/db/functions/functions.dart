import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:slp2/db/models/task_model.dart';

const TASK_DB_NAME = 'task_db';

ValueNotifier<List<TaskModel>> tasksListNotifier = ValueNotifier([]);

Future<void> addTask(TaskModel task) async {
  final taskDB = await Hive.openBox<TaskModel>(TASK_DB_NAME);
  final _id = await taskDB.add(task);
  task.id = _id;

  tasksListNotifier.value.add(task);
  tasksListNotifier.notifyListeners();
}

Future<void> getAllTask() async {
  final box = await Hive.openBox<TaskModel>(TASK_DB_NAME);

  final taskList = <TaskModel>[];

  for (var key in box.keys) {
    final task = box.get(key);
    if (task != null && key is int) {
      task.id = key;
      taskList.add(task);
    }
  }

  taskList.sort((a, b) => a.date.compareTo(b.date));

  tasksListNotifier.value = taskList;
  
  tasksListNotifier.notifyListeners();
}

Future<void> deleteTask(int id) async {
  final taskDB = await Hive.openBox<TaskModel>(TASK_DB_NAME);
  await taskDB.delete(id);
  await getAllTask();
}

Future<void> updateTask(TaskModel task) async {
  final taskDB = await Hive.openBox<TaskModel>(TASK_DB_NAME);
  await taskDB.put(task.id, task);
  await getAllTask();
  tasksListNotifier.notifyListeners();
}

import 'package:hive_flutter/hive_flutter.dart';

part 'task_model.g.dart';

@HiveType(typeId: 1)
class TaskModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String task;

  @HiveField(2)
  final DateTime date;
  // final bool isDeleted;

  TaskModel({
    required this.task,
    required this.date,
    this.id,
    // this.isDeleted = false,
  });
}

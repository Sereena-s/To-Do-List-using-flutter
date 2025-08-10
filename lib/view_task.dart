import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:slp2/db/functions/functions.dart';
import 'package:slp2/db/models/task_model.dart';
import 'package:slp2/edit_task.dart';
import 'package:intl/intl.dart';

class ViewTaskWidget extends StatelessWidget {
  const ViewTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: tasksListNotifier,
      builder: (BuildContext ctx, List<TaskModel> tasks, Widget? _) {
        return ListView.separated(
          itemBuilder: (ctx, index) {
            final task = tasks[index];
            return Slidable(
              startActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (ctx) => deleteTask(index),
                    backgroundColor: Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ],
              ),
              child: ListTile(
                title: Text(task.task),
                subtitle: Text(DateFormat('dd-MM-yyyy').format(task.date)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        editPopUp(
                          context,
                          TaskModel(
                            task: task.task,
                            date: task.date,
                            id: task.id,
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        deleteTask(index);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (ctx, index) => const Divider(),
          itemCount: tasks.length,
        );
      },
    );
  }
}

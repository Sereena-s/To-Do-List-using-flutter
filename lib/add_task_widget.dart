import 'package:flutter/material.dart';
import 'package:slp2/db/functions/functions.dart';
import 'package:slp2/db/models/task_model.dart';

TextEditingController taskController = TextEditingController();
DateTime? _selectedDate;

class AddTaskWidget extends StatefulWidget {
  const AddTaskWidget({super.key});

  @override
  State<AddTaskWidget> createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            controller: taskController,
            decoration: InputDecoration(
              labelText: 'Enter Task',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.purpleAccent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.purple, width: 2),
              ),
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextButton.icon(
            onPressed: () async {
              final selectedDateTemp = await showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 100)),
              );
              if (selectedDateTemp == null) {
                return;
              } else {
                setState(() {
                  _selectedDate = selectedDateTemp;
                });
              }
            },
            icon: const Icon(Icons.calendar_today),
            label: Text(
              _selectedDate == null
                  ? 'Select Due Date'
                  : _selectedDate!.toString(),
            ),
          ),
        ),

        // Padding(
        //   padding: const EdgeInsets.all(10.0),
        //   child: TextField(
        //     controller: dateController,
        //     decoration: InputDecoration(
        //       labelText: 'Enter date',
        //       enabledBorder: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(20),
        //         borderSide: const BorderSide(color: Colors.purpleAccent),
        //       ),
        //       focusedBorder: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(20),
        //         borderSide: const BorderSide(color: Colors.purple, width: 2),
        //       ),
        //     ),
        //   ),
        // ),
        
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(minimumSize: const Size(300, 50)),
          onPressed: () {
            addTaskButton();
          },
          icon: const Icon(Icons.add),
          label: Text("ADD"),
        ),
      ],
    );
  }
}

Future<void> addTaskButton() async {
  final task = taskController.text;
 
  if (task.isEmpty) {
    return;
  }
  if(_selectedDate==null){
    return;
  }
  print(task);


  final _student = TaskModel(task: task, date: _selectedDate!);

  addTask(_student);
}

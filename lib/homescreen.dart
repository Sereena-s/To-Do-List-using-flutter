import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slp2/add_task_widget.dart';
import 'package:slp2/db/functions/functions.dart';
import 'package:slp2/loginpage.dart';
import 'package:slp2/view_task.dart';



class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    getAllTask();
    return Scaffold(
      appBar: AppBar(
        title: const Text("TO DO"),
        centerTitle: true,
        backgroundColor: Colors.purpleAccent,
        actions: [
          IconButton(
            onPressed: () {
              signOut(context);
            },
            icon: const Icon(Icons.logout_sharp),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [AddTaskWidget(), Expanded(child: ViewTaskWidget())],
        ),
      ),
    );
  }

  void signOut(BuildContext ctx) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.clear();

    Navigator.of(ctx).pushAndRemoveUntil(
      MaterialPageRoute(builder: (ctx1) => LoginPage()),
      (route) => false,
    );
  }
}






import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/Task.dart';
import 'package:flutter_application_1/widgets/taskForm.dart';
import '../styles/styles.dart';
import 'TaskTile.dart';

class MyTasks extends StatefulWidget {
  const MyTasks({super.key});

  @override
  State<MyTasks> createState() => _MyTasksState();
}

class _MyTasksState extends State<MyTasks> {
  List<Task> _tasks = [];
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.myBackground(),
      appBar: Styles.myAppBar("Eli Ogilvy"),
      body: Container(
        margin: EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Text(
              "My Tasks: $_counter",
              style: Styles.titleStyle(Colors.white),
            ),
            SizedBox(height: 10.0),
            for (Task task in _tasks)
              SingleChildScrollView(
                child: Column(
                  children: [
                    TaskTile(
                      task: task,
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return TaskForm(
                addTask: addTask,
              );
            }),
          );
        },
        backgroundColor: Styles.buttonBackground(),
        child: Icon(
          Icons.create,
          color: Color.fromARGB(255, 219, 18, 209),
        ),
      ),
    );
  }

  void addTask(Task task) {
    setState(() {
      _tasks.add(task);
      _counter++;
    });
  }
}

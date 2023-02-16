import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import '../styles/styles.dart';
import '../widgets/filter_tasks.dart';
import '../widgets/task_list.dart';

class MyTasks extends StatefulWidget {
  const MyTasks({super.key});

  @override
  State<MyTasks> createState() => _MyTasksState();
}

class _MyTasksState extends State<MyTasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.myBackground(),
      appBar: Styles.myAppBar("Eli Ogilvy"),
      body: Container(
        margin: EdgeInsets.all(15.0),
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerRight,
                child: Filter(callback: _refresh)),
            TaskList(
              callback: _refresh,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Beamer.of(context).beamToNamed(
            '/new',
            data: ["Primary", null, _refresh],
          );
        },
        backgroundColor: Styles.buttonBackground(),
        child: Icon(
          Icons.create,
          color: Styles.myBackground(),
        ),
      ),
    );
  }

  _refresh() {
    setState(() {});
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/Task.dart';
import 'package:flutter_application_1/styles/styles.dart';
import 'package:flutter_application_1/widgets/ShowTask.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  const TaskTile({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Styles.myBackground(),
          context: context,
          builder: (BuildContext context) {
            return ShowTask(task: task);
          },
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      tileColor: Styles.buttonBackground(),
      title: Center(
        child: Text(
          task.title,
          style: Styles.taskStyle(Styles.taskSize()),
        ),
      ),
    );
  }
}

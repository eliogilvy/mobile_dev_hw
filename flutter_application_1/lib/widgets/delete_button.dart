import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../classes/app_provider.dart';
import '../classes/task.dart';
import 'styles/styles.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    super.key,
    required this.task,
    required this.callback,
  });
  final Task task;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return IconButton(
      icon: Icon(Icons.delete),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Styles.myBackground(),
              title: Text(
                "Delete task",
                style: Styles.formStyle(
                  Styles.taskSize(),
                ),
              ),
              content: Text(
                "Are you sure you want to delete this task?",
                style: Styles.formStyle(Styles.taskSize()),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    "Cancel",
                    style: Styles.formStyle(Styles.taskSize()),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(
                    "Delete",
                    style: Styles.formStyle(Styles.taskSize()),
                  ),
                  onPressed: () {
                    provider.deleteTask(task);
                    callback();
                    context.pop();
                    context.pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}

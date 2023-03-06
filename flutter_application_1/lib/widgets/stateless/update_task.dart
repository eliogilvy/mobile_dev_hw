import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/app_provider.dart';
import 'package:provider/provider.dart';
import '../../classes/task.dart';
import '../styles/styles.dart';

class UpdateTaskStatus extends StatelessWidget {
  const UpdateTaskStatus(
      {super.key, required this.task, required this.callback});

  final Task task;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    final appInfo = Provider.of<AppProvider>(context, listen: false);
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              title: const Text('Update status'),
              children: [
                for (String status in appInfo.status)
                  SimpleDialogOption(
                    onPressed: () {
                      task.status = status;
                      appInfo.updateTask(task);
                      callback();
                      Navigator.pop(context);
                    },
                    child: Text(
                      status,
                      style: Styles.taskStyle(18.0),
                    ),
                  ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: SimpleDialogOption(
                    onPressed: () {
                      callback();
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

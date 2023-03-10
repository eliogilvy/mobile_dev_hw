import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/styles/styles.dart';
import 'package:flutter_application_1/widgets/stateless/qr_dialog.dart';
import 'package:go_router/go_router.dart';

import '../../classes/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final Function callback;
  const TaskTile({super.key, required this.task, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ListTile(
        onLongPress: () {
          showDialog(
              context: context, builder: ((context) => QRDialog(task: task)));
        },
        onTap: () {
          // context.beamToNamed('/task/${task.id}', data: [task, callback]);
          context.goNamed('task',
              params: {'id': task.id}, extra: [task, callback]);
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
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/task_db_helper.dart';
import 'package:provider/provider.dart';

import '../classes/state_info.dart';
import '../classes/task.dart';
import '../styles/styles.dart';

class TaskDisplay extends StatefulWidget {
  final bool edit;
  Function(bool) updateEdit;
  Function refresh;
  final Task task;
  TaskDisplay(
      {super.key,
      required this.edit,
      required this.updateEdit,
      required this.refresh,
      required this.task});

  @override
  State<TaskDisplay> createState() => _TaskDisplayState();
}

class _TaskDisplayState extends State<TaskDisplay> {
  @override
  Widget build(BuildContext context) {
    if (!widget.edit) {
      return Expanded(
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.task.title,
                style: Styles.titleStyle(
                  Styles.myBackground(),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                widget.updateEdit(widget.edit);
              },
            ),
          ],
        ),
      );
    } else {
      return Expanded(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                key: Key("Edit title"),
                controller: TextEditingController(text: widget.task.title),
                style: Styles.titleStyle(Styles.myBackground()),
                onChanged: (value) {
                  widget.task.title = value;
                },
                maxLength: 25,
                autocorrect: true,
                textCapitalization: TextCapitalization.words,
              ),
            ),
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () async {
                await TaskDatabaseHelper.updateTask(widget.task);
                widget.updateEdit(widget.edit);
                widget.refresh();
              },
            ),
          ],
        ),
      );
    }
  }
}

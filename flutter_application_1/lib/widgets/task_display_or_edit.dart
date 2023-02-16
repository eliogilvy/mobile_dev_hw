import 'package:flutter/material.dart';
import '../classes/task.dart';
import '../styles/styles.dart';

class TaskDisplay extends StatefulWidget {
  final bool edit;
  Function(bool) updateEdit;
  Function(Task) updateTask;
  final Task task;
  final TextEditingController controller;
  TaskDisplay(
      {super.key,
      required this.edit,
      required this.updateEdit,
      required this.updateTask,
      required this.task,
      required this.controller});

  @override
  State<TaskDisplay> createState() => _TaskDisplayState();
}

class _TaskDisplayState extends State<TaskDisplay> {
  @override
  Widget build(BuildContext context) {
    return !widget.edit
        ? Expanded(
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
                    widget.updateEdit;
                  },
                ),
              ],
            ),
          )
        : Expanded(
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    key: Key("Edit title"),
                    controller: widget.controller,
                    style: Styles.titleStyle(Styles.myBackground()),
                    maxLength: 25,
                    autocorrect: true,
                    textCapitalization: TextCapitalization.words,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    widget.updateEdit(widget.edit);
                    widget.updateTask(widget.task);
                  },
                ),
              ],
            ),
          );
  }
}

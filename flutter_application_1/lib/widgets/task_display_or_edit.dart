import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/app_provider.dart';
import 'package:provider/provider.dart';
import '../classes/task.dart';
import '../styles/styles.dart';

class TaskDisplay extends StatefulWidget {
  final bool edit;
  Function(bool) updateEdit;
  Function(AppProvider) refresh;
  final Task task;
  final TextEditingController controller;
  TaskDisplay(
      {super.key,
      required this.edit,
      required this.updateEdit,
      required this.refresh,
      required this.task,
      required this.controller});

  @override
  State<TaskDisplay> createState() => _TaskDisplayState();
}

class _TaskDisplayState extends State<TaskDisplay> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
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
                    provider.deleteTask(widget.task);
                    widget.refresh(provider);
                  },
                ),
              ],
            ),
          );
  }
}

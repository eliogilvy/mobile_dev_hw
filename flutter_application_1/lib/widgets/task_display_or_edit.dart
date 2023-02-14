import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../classes/state_info.dart';
import '../styles/styles.dart';

class TaskDisplay extends StatefulWidget {
  final bool edit;
  Function(bool) callback;
  final int id;
  TaskDisplay(
      {super.key,
      required this.edit,
      required this.callback,
      required this.id});

  @override
  State<TaskDisplay> createState() => _TaskDisplayState();
}

class _TaskDisplayState extends State<TaskDisplay> {
  @override
  Widget build(BuildContext context) {
    final stateInfo = Provider.of<StateInfo>(context, listen: false);
    if (!widget.edit) {
      return Expanded(
        child: Row(
          children: [
            Expanded(
              child: Text(
                stateInfo.getTaskFromMap(widget.id).title,
                style: Styles.titleStyle(
                  Styles.myBackground(),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                widget.callback(widget.edit);
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
                controller: TextEditingController(
                    text: stateInfo.getTaskFromMap(widget.id).title),
                style: Styles.titleStyle(Styles.myBackground()),
                onChanged: (value) {
                  stateInfo.getTaskFromMap(widget.id).title = value;
                },
                maxLength: 25,
                autocorrect: true,
                textCapitalization: TextCapitalization.words,
              ),
            ),
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                widget.callback(widget.edit);
              },
            ),
          ],
        ),
      );
    }
  }
}

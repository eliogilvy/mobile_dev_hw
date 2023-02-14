import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/task_db_helper.dart';
import 'package:flutter_application_1/styles/styles.dart';
import 'package:provider/provider.dart';

import '../classes/state_info.dart';
import '../classes/task.dart';

class RelationshipList extends StatefulWidget {
  RelationshipList({super.key, required this.id, required this.relationship});

  final int id;
  final String relationship;
  late Task task;
  late List<Task> related;
  @override
  State<RelationshipList> createState() => _RelationshipListState();
}

class _RelationshipListState extends State<RelationshipList> {
  @override
  void initState() async {
    super.initState();
    widget.task = await TaskDatabaseHelper.getTask(widget.id);
    widget.related = await TaskDatabaseHelper.getRelatedTasks(widget.task);
  }

  @override
  Widget build(BuildContext context) {
    var stateInfo = Provider.of<StateInfo>(context, listen: true);
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(
        stateInfo.getRelatedTasks(widget.id, widget.relationship).length,
        (i) => TextButton(
            onPressed: () {
              Beamer.of(context).beamToNamed('/task/${widget.task.related[i]}');
            },
            child:
                Text(widget.related[i].title, style: Styles.taskStyle(18.0))),
      ),
    );
  }
}

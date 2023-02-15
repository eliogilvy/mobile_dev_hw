import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../classes/state_info.dart';
import '../classes/task.dart';

class RelationshipList extends StatefulWidget {
  RelationshipList({super.key, required this.task, required this.relationship});

  final String relationship;
  late Task task;
  late List<Task> related;
  @override
  State<RelationshipList> createState() => _RelationshipListState();
}

class _RelationshipListState extends State<RelationshipList> {
  @override
  Widget build(BuildContext context) {
    var stateInfo = Provider.of<StateInfo>(context, listen: true);
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        FutureBuilder<List<Task>>(
          initialData: [],
          future: stateInfo.getRelatedTasks(widget.task, widget.relationship),
          builder: ((context, snapshot) {
            if (snapshot.data!.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {},
              );
            }
          }),
        ),
      ],
    );
  }
}

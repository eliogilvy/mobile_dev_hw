import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/styles/styles.dart';
import 'package:provider/provider.dart';

import '../classes/state_info.dart';

class RelationshipList extends StatefulWidget {
  const RelationshipList(
      {super.key, required this.id, required this.relationship});

  final int id;
  final String relationship;
  @override
  State<RelationshipList> createState() => _RelationshipListState();
}

class _RelationshipListState extends State<RelationshipList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<StateInfo>(builder: (context, stateInfo, child) {
      return Wrap(
        spacing: 8,
        runSpacing: 8,
        children: List.generate(
          stateInfo.getRelatedTasks(widget.id, widget.relationship).length,
          (i) => TextButton(
              onPressed: () {
                Beamer.of(context)
                    .beamToNamed('/task/${stateInfo.relatedTasks[i]}');
              },
              child: Text(
                  stateInfo.getTaskFromMap(stateInfo.relatedTasks[i]).title,
                  style: Styles.taskStyle(18.0))),
        ),
      );
    });
  }
}

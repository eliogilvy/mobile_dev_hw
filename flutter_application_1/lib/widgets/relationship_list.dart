import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/app_provider.dart';
import 'package:provider/provider.dart';

import '../classes/db_provider.dart';
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
    var appInfo = Provider.of<AppProvider>(context, listen: true);
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        FutureBuilder<List<Task>>(
          initialData: [],
          future: appInfo.getRelatedTasks(widget.task, widget.relationship),
          builder: ((context, snapshot) {
            if (snapshot.data!.isNotEmpty) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Task relatedTask = snapshot.data![index];
                  return Text(relatedTask.title);
                },
              );
            }
            return Text("Nothing to be found");
          }),
        ),
      ],
    );
  }
}

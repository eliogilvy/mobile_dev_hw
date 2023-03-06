import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/app_provider.dart';
import 'package:flutter_application_1/widgets/styles/styles.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../classes/task.dart';

class RelationshipList extends StatefulWidget {
  RelationshipList(
      {super.key,
      required this.task,
      required this.relationship,
      required this.callback});

  final String relationship;
  final Task task;
  late List<Task> related;
  Function callback;
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
                  return SizedBox(
                    width: 20,
                    child: TextButton(
                      onPressed: () {
                        // context.beamToNamed('/task/${relatedTask.id}',
                        //     data: [relatedTask, widget.callback]);
                        context.goNamed('task',
                            params: {'id': relatedTask.id},
                            extra: [relatedTask, widget.callback]);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Styles.buttonBackground(),
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        relatedTask.title,
                        style: Styles.taskStyle(Styles.taskSize()),
                      ),
                    ),
                  );
                },
              );
            }
            return Container();
          }),
        ),
      ],
    );
  }
}

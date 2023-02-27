import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/stateless/task_tile.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../classes/app_provider.dart';
import '../classes/task.dart';

class TaskList extends StatefulWidget {
  const TaskList({
    super.key,
    required this.callback,
  });
  final Function callback;

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    var appInfo = Provider.of<AppProvider>(context, listen: true);
    return Flexible(
      // child: FutureBuilder<List<Task>>(
      //   future: appInfo.tasks,
      //   initialData: [],
      //   builder: (context, snapshot) {
      //     if (snapshot.data == null || snapshot.data!.isEmpty) {
      //       return Center(
      //         child: Text('Nothing to see...'),
      //       );
      //     }
      //     return ListView.builder(
      //       itemCount: snapshot.data!.length,
      //       itemBuilder: (context, index) {
      //         return TaskTile(
      //           task: snapshot.data![index],
      //           callback: widget.callback,
      //         );
      //       },
      //     );
      //   },
      // ),
      child: StreamBuilder(
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                Task task = Task.fromMap(snapshot.data!.docs[0].data() as Map);
                return TaskTile(
                  task: task,
                  callback: widget.callback,
                );
              },
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

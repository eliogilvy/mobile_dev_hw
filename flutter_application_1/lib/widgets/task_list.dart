import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/stateless/task_tile.dart';
import 'package:provider/provider.dart';

import '../classes/state_info.dart';
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
    var stateInfo = Provider.of<StateInfo>(context, listen: true);
    return Flexible(
      child: FutureBuilder<List<Task>>(
        future: stateInfo.tasks,
        initialData: [],
        builder: (context, snapshot) {
          if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(
              child: Text('Nothing to see...'),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return TaskTile(
                task: snapshot.data![index],
                callback: widget.callback,
              );
            },
          );
        },
      ),
    );
  }
}

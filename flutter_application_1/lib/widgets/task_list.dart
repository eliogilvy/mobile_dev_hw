import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/task_tile.dart';

import '../classes/task.dart';
import '../database/task_db_helper.dart';

class TaskList extends StatefulWidget {
  const TaskList({
    super.key,
  });

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FutureBuilder<List<Task>>(
        future: TaskDatabaseHelper.getTasks(),
        initialData: [],
        builder: (BuildContext context, snapshot) {
          return snapshot.data!.isEmpty
              ? Center(child: Text('Loading...'))
              : ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return TaskTile(
                      id: snapshot.data![index].id,
                      title: snapshot.data![index].title,
                    );
                  },
                );
        },
      ),
    );
  }
}

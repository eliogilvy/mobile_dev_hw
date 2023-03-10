import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/app_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../classes/task.dart';
import 'styles/styles.dart';

class AddRelationship extends StatelessWidget {
  const AddRelationship(
      {super.key,
      required this.task,
      required this.callback,
      required this.relationship});
  final Task task;
  final Function callback;
  final String relationship;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: Styles.myBackground(),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                IconButton(
                    icon: Icon(Icons.add),
                    color: Styles.buttonBackground(),
                    onPressed: () => context
                        .goNamed('new', extra: [relationship, task, callback])),
                Text(
                  "Create new task",
                  style: Styles.formStyle(Styles.formSize()),
                ),
              ],
            ),
            SizedBox(width: 10.0),
            Column(
              children: [
                IconButton(
                  icon: Icon(Icons.playlist_add_check),
                  color: Styles.buttonBackground(),
                  onPressed: () {
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        backgroundColor: Styles.myBackground(),
                        child: MiniTaskList(
                          relationship: relationship,
                          task: task,
                          callback: callback,
                        ),
                      ),
                    );
                  },
                ),
                Text(
                  "Select existing task",
                  style: Styles.formStyle(
                    Styles.formSize(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class MiniTaskList extends StatelessWidget {
  const MiniTaskList({
    super.key,
    required this.relationship,
    required this.task,
    required this.callback,
  });
  final String relationship;
  final Task task;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    final appInfo = Provider.of<AppProvider>(context);
    return FutureBuilder<List<Task>>(
      future: appInfo.sharedOrLocal(task),
      builder: (context, snapshot) {
        if (snapshot.data == null || snapshot.data!.isEmpty) {
          return Center(
            child: Text('Nothing to see...'),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return snapshot.data![index].id != task.id
                ? ListTile(
                    title: Text(
                      snapshot.data![index].title,
                      style: Styles.titleStyle(
                        Colors.white,
                      ),
                    ),
                    onTap: () {
                      appInfo
                          .addRelationship(
                              snapshot.data![index], task, relationship)
                          .then((value) {
                        callback();
                        Navigator.of(context).pop();
                      });
                    },
                  )
                : Container();
          },
        );
      },
    );
  }
}

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../classes/state_info.dart';
import '../classes/task.dart';
import '../styles/styles.dart';

class AddRelationShip extends StatelessWidget {
  const AddRelationShip(
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
      children: [
        Container(
          alignment: Alignment.centerLeft,
          width: MediaQuery.of(context).size.width / 2,
          color: Styles.myBackground(),
          child: ElevatedButton(
            onPressed: () => Beamer.of(context).beamToNamed(
              '/new',
              data: [relationship, task, callback],
            ),
            child: Text("Create new task"),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          width: MediaQuery.of(context).size.width / 2,
          color: Styles.myBackground(),
          child: ElevatedButton(
            onPressed: () => showDialog(
              context: context,
              builder: (context) => Dialog(
                backgroundColor: Styles.myBackground(),
                child: MiniTaskList(
                  relationship: relationship,
                  task: task,
                  callback: callback,
                ),
              ),
            ),
            child: Text("Add existing task"),
          ),
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
    final stateInfo = Provider.of<StateInfo>(context);
    return Flexible(
      child: FutureBuilder<List<Task>>(
        future: stateInfo.tasks,
        initialData: [],
        builder: (context, snapshot) {
          if (snapshot.data!.isEmpty) {
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
                        stateInfo.addRelationship(
                            snapshot.data![index], task, relationship);
                        Beamer.of(context).beamToNamed('/task/${task.id}',
                            data: [task, callback]);
                      },
                    )
                  : Container();
            },
          );
        },
      ),
    );
  }
}

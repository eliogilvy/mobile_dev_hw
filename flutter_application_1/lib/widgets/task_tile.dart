import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/styles/styles.dart';
import 'package:provider/provider.dart';
import '../classes/state_info.dart';

class TaskTile extends StatelessWidget {
  final int id;
  const TaskTile({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Consumer<StateInfo>(
      builder: (context, stateInfo, child) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: ListTile(
            onTap: () {
              Beamer.of(context)
                  .beamToNamed('/task/${stateInfo.getTaskFromMap(id).id}');
              // showDialog(
              //   context: context,
              //   builder: (BuildContext context) {
              //     return WillPopScope(
              //       onWillPop: () async {
              //         stateInfo.clearRelatedTasks();
              //         Navigator.of(context).pop();
              //         return false;
              //       },
              //       child: ShowTask(id: id),
              //     );
              //   },
              // );
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            tileColor: Styles.buttonBackground(),
            title: Center(
              child: Text(
                stateInfo.getTaskFromMap(id).title,
                style: Styles.taskStyle(Styles.taskSize()),
              ),
            ),
          ),
        );
      },
    );
  }
}

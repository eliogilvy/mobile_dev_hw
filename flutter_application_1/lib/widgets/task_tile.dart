import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/styles/styles.dart';
import 'package:provider/provider.dart';
import '../classes/state_info.dart';

class TaskTile extends StatelessWidget {
  final int id;
  final String title;
  const TaskTile({super.key, required this.id, required this.title});

  @override
  Widget build(BuildContext context) {
    return Consumer<StateInfo>(
      builder: (context, stateInfo, child) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: ListTile(
            onTap: () {
              Beamer.of(context).beamToNamed('/task/$id');
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            tileColor: Styles.buttonBackground(),
            title: Center(
              child: Text(
                title,
                style: Styles.taskStyle(Styles.taskSize()),
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:beamer/beamer.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../classes/state_info.dart';
import '../styles/styles.dart';
import '../widgets/filter_tasks.dart';
import '../widgets/task_tile.dart';

class MyTasks extends StatelessWidget {
  const MyTasks({super.key});

  @override
  Widget build(BuildContext context) {
    final beamer = Beamer.of(context);
    return Scaffold(
      backgroundColor: Styles.myBackground(),
      appBar: Styles.myAppBar("Eli Ogilvy"),
      body: Container(
        margin: EdgeInsets.all(15.0),
        child: Consumer<StateInfo>(
          builder: ((context, stateInfo, child) {
            return Column(
              children: [
                Align(alignment: Alignment.centerRight, child: Filter()),
                Flexible(
                  child: ListView.builder(
                    itemCount: stateInfo.tasks.length,
                    itemBuilder: (context, index) {
                      return TaskTile(
                        id: stateInfo.getTaskFromList(index).id,
                      );
                    },
                  ),
                ),
              ],
            );
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          beamer.beamToNamed(
            '/new',
            data: ["Primary", -1],
          );
        },
        backgroundColor: Styles.buttonBackground(),
        child: Icon(
          Icons.create,
          color: Styles.myBackground(),
        ),
      ),
    );
  }
}

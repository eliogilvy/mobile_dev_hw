import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/description_box.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../classes/state_info.dart';
import '../styles/styles.dart';
import '../widgets/filter_selection.dart';
import '../widgets/form/add_related_task.dart';
import '../widgets/related_task_button.dart';
import '../widgets/relationship_list.dart';

class TaskPage extends StatelessWidget {
  TaskPage({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.myBackground(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 22, 0, 0),
        child: Consumer<StateInfo>(
          builder: (context, stateInfo, child) {
            return SizedBox(
              height: double.infinity,
              child: Card(
                color: Styles.buttonBackground(),
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              stateInfo.getTaskFromMap(id).title,
                              style: Styles.titleStyle(
                                Styles.myBackground(),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Styles.myBackground(),
                                    title: Text(
                                      "Delete task",
                                      style: Styles.formStyle(
                                        Styles.taskSize(),
                                      ),
                                    ),
                                    content: Text(
                                      "Are you sure you want to delete this task?",
                                      style:
                                          Styles.formStyle(Styles.taskSize()),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text(
                                          "Cancel",
                                          style: Styles.formStyle(
                                              Styles.taskSize()),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: Text(
                                          "Delete",
                                          style: Styles.formStyle(
                                              Styles.taskSize()),
                                        ),
                                        onPressed: () {
                                          stateInfo.removeTask(id);
                                          Beamer.of(context).beamBack();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          IconButton(
                            onPressed: () {
                              stateInfo.clearRelatedTasks();
                              Beamer.of(context).beamBack();
                            },
                            icon: Icon(Icons.close),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          stateInfo.getTaskFromMap(id).taskType,
                          style: Styles.taskStyle(12),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      DescriptionBox(desc: stateInfo.getTaskFromMap(id).desc),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          RelatedTaskButton(id: id),
                          // IconButton(
                          //   icon: Icon(Icons.edit),
                          //   onPressed: (() => print("pressed")),
                          // ),
                        ],
                      ),
                      if (stateInfo.getPluralRelationship(
                              stateInfo.getTaskFromMap(id).lastFilter) ==
                          null)
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text("Tap a button to show related tasks")),
                      if (stateInfo.getPluralRelationship(
                              stateInfo.getTaskFromMap(id).lastFilter) !=
                          null)
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                              "Showing ${stateInfo.getPluralRelationship(stateInfo.getTaskFromMap(id).lastFilter)}"),
                        ),
                      // Align(
                      //   alignment: Alignment.topLeft,
                      //   child: Padding(
                      //     padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                      //     child: Text(
                      //         "Showing ${stateInfo.getPluralRelationship(stateInfo.)}"),
                      //   ),
                      // ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: RelationshipList(
                            id: stateInfo.getTaskFromMap(id).id,
                            relationship:
                                stateInfo.getTaskFromMap(id).lastFilter),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    stateInfo.getTaskFromMap(id).status,
                                    style: Styles.taskStyle(18.0),
                                  ),
                                  DialogButton(
                                    id: stateInfo.getTaskFromMap(id).id,
                                  ),
                                ],
                              ),
                              Text(
                                DateFormat('MM/dd/yy h:mm a').format(
                                    stateInfo.getTaskFromMap(id).lastUpdate),
                                style: Styles.taskStyle(15.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: Consumer<StateInfo>(
        builder: (context, stateInfo, child) => FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return RelationshipSelect(
                  relatedId: stateInfo.getTaskFromMap(id).id,
                );
              },
            );
          },
          backgroundColor: Styles.myBackground(),
          tooltip: "Add related task",
          child: Icon(
            Icons.add,
            color: Styles.buttonBackground(),
          ),
        ),
      ),
    );
  }
}

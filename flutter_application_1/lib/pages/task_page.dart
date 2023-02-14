import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/task_db_helper.dart';
import 'package:flutter_application_1/widgets/description_box.dart';
import 'package:flutter_application_1/widgets/edit_description_box.dart';
import 'package:flutter_application_1/widgets/task_display_or_edit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../classes/state_info.dart';
import '../classes/task.dart';
import '../styles/styles.dart';
import '../widgets/filter_selection.dart';
import '../widgets/form/add_related_task.dart';
import '../widgets/related_task_button.dart';

class TaskPage extends StatefulWidget {
  TaskPage({super.key, required this.id});

  final int id;
  bool _editing = false;

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Styles.myBackground(),
      body: FutureBuilder(
        future: TaskDatabaseHelper.getTask(widget.id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: Text('Loading...'));
          }
          Task task = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 22, 0, 0),
            child: SizedBox(
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
                          TaskDisplay(
                              edit: widget._editing,
                              callback: updateEdit,
                              id: widget.id),
                          DeleteButton(id: widget.id),
                          IconButton(
                            onPressed: () {
                              Beamer.of(context).beamBack();
                            },
                            icon: Icon(Icons.close),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          task.taskType,
                          style: Styles.taskStyle(12),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      if (!widget._editing) DescriptionBox(desc: task.desc),
                      if (widget._editing)
                        EditDescBox(
                          desc: task.desc,
                          callback: (String value) async {
                            task.desc = value;
                            await TaskDatabaseHelper.updateTask(task);
                          },
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          RelatedTaskButton(id: widget.id),
                        ],
                      ),
                      // if (stateInfo.getPluralRelationship(
                      //         stateInfo.getTaskFromMap(widget.id).lastFilter) ==
                      //     null)
                      //   Align(
                      //       alignment: Alignment.topLeft,
                      //       child: Text("Tap a button to show related tasks")),
                      // if (stateInfo.getPluralRelationship(
                      //         stateInfo.getTaskFromMap(widget.id).lastFilter) !=
                      //     null)
                      //   Align(
                      //     alignment: Alignment.topLeft,
                      //     child: Text(
                      //         "Showing ${stateInfo.getPluralRelationship(stateInfo.getTaskFromMap(widget.id).lastFilter)}"),
                      //   ),
                      // Align(
                      //   alignment: Alignment.topLeft,
                      //   child: RelationshipList(
                      //       id: stateInfo.getTaskFromMap(widget.id).id,
                      //       relationship:
                      //           stateInfo.getTaskFromMap(widget.id).lastFilter),
                      // ),
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
                                    task.status,
                                    style: Styles.taskStyle(18.0),
                                  ),
                                  DialogButton(
                                    id: task.id,
                                  ),
                                ],
                              ),
                              Text(
                                DateFormat('MM/dd/yy h:mm a')
                                    .format(task.lastUpdate),
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
            ),
          );
        },
      ),
      floatingActionButton: Consumer<StateInfo>(
        builder: (context, stateInfo, child) => FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return RelationshipSelect(
                  relatedId: stateInfo.getTaskFromMap(widget.id).id,
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

  void updateEdit(bool edit) {
    if (edit) {
      widget._editing = false;
    } else {
      widget._editing = true;
    }
    setState(() {});
  }
}

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    super.key,
    required this.id,
  });

  final int id;

  @override
  Widget build(BuildContext context) {
    return IconButton(
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
                style: Styles.formStyle(Styles.taskSize()),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    "Cancel",
                    style: Styles.formStyle(Styles.taskSize()),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(
                    "Delete",
                    style: Styles.formStyle(Styles.taskSize()),
                  ),
                  onPressed: () async {
                    await TaskDatabaseHelper.deleteTask(id);
                    Beamer.of(context).beamBack();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}

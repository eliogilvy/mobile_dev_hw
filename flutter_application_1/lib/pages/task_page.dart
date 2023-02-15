import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/task_db_helper.dart';
import 'package:flutter_application_1/widgets/stateless/description_box.dart';
import 'package:flutter_application_1/widgets/edit_description_box.dart';
import 'package:flutter_application_1/widgets/task_display_or_edit.dart';
import 'package:intl/intl.dart';
import '../classes/task.dart';
import '../styles/styles.dart';
import '../widgets/relationship_list.dart';
import '../widgets/stateless/update_task.dart';
import '../widgets/form/add_related_task.dart';
import '../widgets/stateless/filter_task_button.dart';

// ignore: must_be_immutable
class TaskPage extends StatefulWidget {
  TaskPage({super.key, required this.id, required this.callback});
  final int id;
  bool _editing = false;
  final Function callback;
  String _relationship = "";

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  _refresh({String? relationship}) {
    if (relationship != null) {
      widget._relationship = relationship;
    }
    setState(() {});
  }

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
                              updateEdit: updateEdit,
                              refresh: _refresh,
                              task: task),
                          DeleteButton(
                            id: widget.id,
                            callback: widget.callback,
                          ),
                          IconButton(
                            onPressed: () {
                              widget.callback();
                              Beamer.of(context).beamToNamed('/');
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
                        DescBox(
                          desc: task.desc,
                          callback: _callback,
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FilterTasksButton(
                            callback: _refresh,
                          ),
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
                      Align(
                        alignment: Alignment.topLeft,
                        child: RelationshipList(
                          task: task,
                          relationship: widget._relationship,
                        ),
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
                                    task.status,
                                    style: Styles.taskStyle(18.0),
                                  ),
                                  UpdateTaskStatus(
                                    task: task,
                                    callback: _refresh,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddRelatedTask(
                relatedId: widget.id,
                callback: widget.callback,
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
    );
  }

  _callback(String text) {}

  void updateDesc(Task task, String desc) async {
    task.desc = desc;
    await TaskDatabaseHelper.updateTask(task);
    _refresh();
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
    required this.callback,
  });
  final int id;
  final Function callback;

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
                  onPressed: () {
                    TaskDatabaseHelper.deleteTask(id);
                    callback();
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

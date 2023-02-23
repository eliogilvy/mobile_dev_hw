import 'dart:io';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/database/task_db_helper.dart';
import 'package:flutter_application_1/widgets/add_image.dart';
import 'package:flutter_application_1/widgets/add_relationship.dart';
import 'package:flutter_application_1/widgets/stateless/description_box.dart';
import 'package:flutter_application_1/widgets/task_display_or_edit.dart';
import 'package:flutter_application_1/widgets/task_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../classes/task.dart';
import '../styles/styles.dart';
import '../widgets/delete_button.dart';
import '../widgets/relationship_list.dart';
import '../widgets/stateless/update_task.dart';
import '../widgets/form/add_related_task.dart';
import '../widgets/stateless/filter_task_button.dart';

// ignore: must_be_immutable
class TaskPage extends StatefulWidget {
  TaskPage({super.key, required this.task, required this.callback});
  final Task task;
  bool _editing = false;
  final Function callback;
  String _relationship = "";

  late TextEditingController titleController =
      TextEditingController(text: task.title);
  late TextEditingController descController =
      TextEditingController(text: task.desc);
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
      backgroundColor: Styles.myBackground(),
      body: Padding(
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
                          controller: widget.titleController,
                          edit: widget._editing,
                          updateEdit: updateEdit,
                          updateTask: updateTask,
                          task: widget.task),
                      ImageButton(
                        task: widget.task,
                        callback: _refresh,
                      ),
                      DeleteButton(
                        id: widget.task.id,
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
                      widget.task.taskType,
                      style: Styles.taskStyle(12),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          widget.task.image != null
                              ? TaskImage(
                                  image: widget.task.image!,
                                )
                              : Container(),
                          DescriptionBox(
                            controller: widget.descController,
                            edit: widget._editing,
                            task: widget.task,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FilterTasksButton(
                                callback: _refresh,
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: RelationshipList(
                              task: widget.task,
                              relationship: widget._relationship,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Row(
                                  children: [
                                    Text(
                                      widget.task.status,
                                      style: Styles.taskStyle(18.0),
                                    ),
                                    UpdateTaskStatus(
                                      task: widget.task,
                                      callback: _refresh,
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                DateFormat('MM/dd/yy h:mm a')
                                    .format(widget.task.lastUpdate),
                                style: Styles.taskStyle(15.0),
                              ),
                            ],
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddRelatedTask(
                  relatedTask: widget.task, callback: widget.callback);
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

  void updateEdit(bool edit) {
    if (edit) {
      widget._editing = false;
    } else {
      widget._editing = true;
    }
    setState(() {});
  }

  void updateTask(Task task) async {
    task.title = widget.titleController.text;
    task.desc = widget.descController.text;
    await TaskDatabaseHelper.updateTask(task);
    setState(() {});
  }
}

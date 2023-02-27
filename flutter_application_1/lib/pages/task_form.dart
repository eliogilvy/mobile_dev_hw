import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/app_provider.dart';
import 'package:flutter_application_1/classes/db_provider.dart';
import 'package:provider/provider.dart';
import '../classes/task.dart';
import '../styles/styles.dart';
import '../widgets/form/form_components.dart';

// ignore: must_be_immutable
class TaskForm extends StatefulWidget {
  String _relationship = "";
  Task? _relatedTask;
  Function? callback;

  TaskForm({super.key, required this.data}) {
    _relationship = data[0];
    _relatedTask = data[1];
    callback = data[2];
  }

  final List data;

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  bool _recurring = false;

  bool shared = false;

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descController = TextEditingController();

  String _selectedStatus = "Open";

  final GlobalKey<FormState> taskForm = GlobalKey<FormState>();

  void _updateSelected(String selected) {
    _selectedStatus = selected;
  }

  @override
  Widget build(BuildContext context) {
    final appInfo = Provider.of<AppProvider>(context);
    return Scaffold(
      backgroundColor: Styles.myBackground(),
      appBar: Styles.myAppBar("Create a New Task"),
      body: SingleChildScrollView(
        child: Card(
          color: Styles.myBackground(),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: taskForm,
              child: Column(
                children: [
                  FormComponents.buildTitle(_titleController),
                  SizedBox(height: 10),
                  FormComponents.buildDesc(_descController),
                  SizedBox(height: 20),
                  FormComponents.buildDropdown(
                    context,
                    _selectedStatus,
                    appInfo.status,
                    "Select a Status",
                    _updateSelected,
                  ),
                  SizedBox(height: 20),
                  if (widget._relationship == "Primary")
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Recurring",
                              style: Styles.formStyle(Styles.formSize()),
                            ),
                            Flexible(
                              child: RadioListTile<bool>(
                                activeColor: Styles.buttonBackground(),
                                title: Text(
                                  "Yes",
                                  style: Styles.formStyle(Styles.formSize()),
                                ),
                                value: true,
                                groupValue: _recurring,
                                onChanged: (value) {
                                  setState(() {
                                    _recurring = value!;
                                  });
                                },
                              ),
                            ),
                            Flexible(
                              child: RadioListTile<bool>(
                                activeColor: Styles.buttonBackground(),
                                title: Text(
                                  "No",
                                  style: Styles.formStyle(Styles.formSize()),
                                ),
                                value: false,
                                groupValue: _recurring,
                                onChanged: (value) {
                                  setState(() {
                                    _recurring = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              child: RadioListTile<bool>(
                                activeColor: Styles.buttonBackground(),
                                title: Text(
                                  "Local",
                                  style: Styles.formStyle(Styles.formSize()),
                                ),
                                value: false,
                                groupValue: shared,
                                onChanged: (value) {
                                  setState(() {
                                    shared = value!;
                                  });
                                },
                              ),
                            ),
                            Flexible(
                              child: RadioListTile<bool>(
                                activeColor: Styles.buttonBackground(),
                                title: Text(
                                  "Shared",
                                  style: Styles.formStyle(Styles.formSize()),
                                ),
                                value: true,
                                groupValue: shared,
                                onChanged: (value) {
                                  setState(() {
                                    shared = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Styles.buttonBackground()),
                    onPressed: () async {
                      if (taskForm.currentState!.validate()) {
                        Task task = Task(
                          title: _titleController.text,
                          desc: _descController.text,
                          status: _selectedStatus,
                          shared: shared,
                          lastUpdate: DateTime.now(),
                          taskType: widget._relationship,
                          related: {},
                        );
                        if (_recurring == true) {
                          task.taskType = "Recurring";
                        }
                        String id = await appInfo.addTask(task);
                        task.id = id;
                        if (widget._relatedTask != null) {
                          task = await appInfo.getTask(task);
                          appInfo.addRelationship(
                              task, widget._relatedTask!, widget._relationship);
                        }
                        widget.callback!();
                        Beamer.of(context).beamToNamed('/');
                      }
                    },
                    child: Text(
                      'Create Task',
                      style: Styles.taskStyle(20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

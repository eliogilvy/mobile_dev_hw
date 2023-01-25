import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/state_info.dart';
import 'package:provider/provider.dart';
import '../../classes/task.dart';
import '../../styles/styles.dart';
import 'form_components.dart';

// ignore: must_be_immutable
class TaskForm extends StatefulWidget {
  String _relationship = "";
  int _relatedId = -1;

  TaskForm({super.key, required this.data}) {
    _relationship = data[0];
    _relatedId = data[1];
  }

  final List data;

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  bool _recurring = false;

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descController = TextEditingController();

  String _selectedStatus = "Open";

  final GlobalKey<FormState> taskForm = GlobalKey<FormState>();

  void _updateSelected(String selected) {
    _selectedStatus = selected;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StateInfo>(
      builder: (context, stateInfo, child) {
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
                        stateInfo.status,
                        "Select a Status",
                        _updateSelected,
                      ),
                      SizedBox(height: 20),
                      if (widget._relationship == "Primary")
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Recurring?",
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
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Styles.buttonBackground()),
                        onPressed: () {
                          if (taskForm.currentState!.validate()) {
                            final task = Task(
                              id: 0,
                              title: _titleController.text,
                              desc: _descController.text,
                              status: _selectedStatus,
                              lastUpdate: DateTime.now(),
                              taskType: widget._relationship,
                            );
                            if (_recurring == true) {
                              task.taskType = "Recurring";
                            }
                            stateInfo.addTask(task);
                            if (widget._relatedId != -1) {
                              stateInfo.addRelationship(stateInfo.count,
                                  widget._relatedId, widget._relationship);
                            }
                            FocusScope.of(context).unfocus();
                            Beamer.of(context).beamBack();
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
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/myTasks.dart';
import '../classes/Task.dart';
import '../styles/styles.dart';
import 'TaskTile.dart';

class TaskForm extends StatelessWidget {
  final Function(Task) addTask;
  TaskForm({super.key, required this.addTask});

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  List _status = ['Open', 'In Progress', 'Closed'];
  String _selectedStatus = "Open";
  DateTime _time = DateTime.now();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _validate(value) {
    if (value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  Widget _buildTitle() {
    return TextFormField(
      validator: (value) => _validate(value),
      autocorrect: true,
      textCapitalization: TextCapitalization.words,
      style: Styles.formStyle(Styles.formSize()),
      decoration: Styles.myFormStyle('Title'),
      controller: _titleController,
    );
  }

  Widget _buildDesc() {
    return TextFormField(
      validator: ((value) => _validate(value)),
      autocorrect: true,
      textCapitalization: TextCapitalization.sentences,
      style: Styles.formStyle(Styles.formSize()),
      decoration: Styles.myFormStyle('Description'),
      keyboardType: TextInputType.multiline,
      controller: _descController,
      maxLines: 5,
    );
  }

  Widget _buildStatus() {
    return DropdownButtonFormField(
      style: Styles.formStyle(18),
      dropdownColor: Styles.myBackground(),
      hint: Text(
        "Select a Status",
        style: Styles.formStyle(Styles.formSize()),
      ),
      value: _selectedStatus,
      onChanged: (value) {
        _selectedStatus = value as String;
      },
      items: _status.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(
            item,
            style: Styles.formStyle(18.0),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.myBackground(),
      appBar: Styles.myAppBar("Create a New Task"),
      body: SingleChildScrollView(
        child: Card(
          color: Styles.myBackground(),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              child: Column(
                children: [
                  _buildTitle(),
                  SizedBox(height: 10),
                  _buildDesc(),
                  SizedBox(height: 20),
                  _buildStatus(),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      final task = Task(
                        title: _titleController.text,
                        desc: _descController.text,
                        status: _selectedStatus,
                        lastUpdate: DateTime.now(),
                      );
                      addTask(task);
                      FocusScope.of(context).unfocus();
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Create Task',
                      style: Styles.formStyle(20),
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

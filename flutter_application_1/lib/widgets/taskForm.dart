import 'package:flutter/material.dart';
import '../styles/styles.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({super.key});

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  String? _title;
  String? _description;
  List _status = ['Open', 'In Progress', 'Closed'];
  String? _selectedStatus;
  DateTime _time = DateTime.now();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTitle() {
    return TextFormField(
      style: Styles.formStyle(),
      decoration: Styles.myFormStyle('Title'),
    );
  }

  Widget _buildDesc() {
    return TextFormField(
      style: Styles.formStyle(),
      decoration: Styles.myFormStyle('Description'),
      keyboardType: TextInputType.multiline,
      maxLines: 5,
    );
  }

  Widget _buildStatus() {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Styles.myBackground(),
      ),
      child: DropdownButtonFormField(
        hint: Text(
          "Select a Status",
          style: Styles.formStyle(),
        ),
        value: _selectedStatus,
        onChanged: (value) {
          setState(() {
            _selectedStatus = value as String;
          });
        },
        items: _status.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(
              item,
              style: Styles.formStyle(),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.myBackground(),
      appBar: Styles.myAppBar("Create a New Task"),
      body: Container(
        height: 500,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 2.0,
          ),
        ),
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                _buildTitle(),
                SizedBox(height: 10),
                _buildDesc(),
                SizedBox(height: 10),
                _buildStatus(),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

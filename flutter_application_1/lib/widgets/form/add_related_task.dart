import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/app_provider.dart';
import 'package:flutter_application_1/widgets/styles/styles.dart';
import 'package:flutter_application_1/widgets/add_relationship.dart';
import 'package:flutter_application_1/widgets/form/form_components.dart';
import 'package:provider/provider.dart';

import '../../classes/task.dart';

class AddRelatedTask extends StatelessWidget {
  AddRelatedTask(
      {super.key, required this.relatedTask, required this.callback});
  final Task relatedTask;
  final Function callback;

  final GlobalKey<FormState> _relatedForm = GlobalKey<FormState>();
  String _selectedRelationship = "Subtask";

  void _updateRelationship(String rel) {
    _selectedRelationship = rel;
  }

  @override
  Widget build(BuildContext context) {
    var appInfo = Provider.of<AppProvider>(context, listen: false);
    return AlertDialog(
      backgroundColor: Styles.myBackground(),
      contentPadding: EdgeInsets.all(0),
      content: SizedBox(
        height: 150.0,
        child: Card(
          color: Styles.myBackground(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FormComponents.buildDropdown(
                  context,
                  _selectedRelationship,
                  appInfo.relatedTaskDropdown(),
                  "Select a relationship",
                  _updateRelationship,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 13, 0, 0),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Styles.buttonBackground(),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AddRelationship(
                                task: relatedTask,
                                callback: callback,
                                relationship: _selectedRelationship);
                          },
                        );
                      },
                      alignment: Alignment.center,
                      icon: Icon(
                        Icons.arrow_right_alt_rounded,
                        color: Styles.myBackground(),
                        size: 30,
                      ),
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

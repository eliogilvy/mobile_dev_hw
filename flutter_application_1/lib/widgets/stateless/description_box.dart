import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/edit_description_box.dart';

import '../../classes/task.dart';
import '../styles/styles.dart';

class DescriptionBox extends StatelessWidget {
  const DescriptionBox(
      {super.key,
      required this.controller,
      required this.edit,
      required this.task});

  final bool edit;
  final TextEditingController controller;
  final Task task;

  @override
  Widget build(BuildContext context) {
    return !edit
        ? Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(5)),
            child: Text(
              task.desc,
              style: Styles.taskStyle(18.0),
            ),
          )
        : EditDescriptionBox(
            controller: controller,
            task: task,
          );
  }
}

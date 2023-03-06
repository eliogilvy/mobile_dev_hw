import 'package:flutter/material.dart';

import '../classes/task.dart';
import 'styles/styles.dart';

class EditDescriptionBox extends StatefulWidget {
  const EditDescriptionBox(
      {super.key, required this.controller, required this.task});

  final TextEditingController controller;
  final Task task;

  @override
  State<EditDescriptionBox> createState() => _EditDescriptionBoxState();
}

class _EditDescriptionBoxState extends State<EditDescriptionBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(5)),
      child: SingleChildScrollView(
        child: TextField(
          key: Key("Edit desc"),
          maxLength: 250,
          autocorrect: true,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
          onChanged: (value) {},
          controller: widget.controller,
          style: Styles.taskStyle(18.0),
          keyboardType: TextInputType.multiline,
          maxLines: 5,
        ),
      ),
    );
  }
}

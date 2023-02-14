import 'package:flutter/material.dart';

import '../styles/styles.dart';

class EditDescBox extends StatefulWidget {
  const EditDescBox({super.key, required this.desc, required this.callback});

  final Function(String) callback;
  final String desc;

  @override
  State<EditDescBox> createState() => _EditDescBoxState();
}

class _EditDescBoxState extends State<EditDescBox> {
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
          onChanged: (value) {
            widget.callback(value);
          },
          controller: TextEditingController(text: widget.desc),
          style: Styles.taskStyle(18.0),
          keyboardType: TextInputType.multiline,
          maxLines: 5,
        ),
      ),
    );
  }
}

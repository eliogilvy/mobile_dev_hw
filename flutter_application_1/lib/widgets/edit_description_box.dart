import 'package:flutter/material.dart';

import '../styles/styles.dart';

class DescBox extends StatefulWidget {
  const DescBox({super.key, required this.desc, required this.callback});

  final Function callback;
  final String desc;

  @override
  State<DescBox> createState() => _DescBoxState();
}

class _DescBoxState extends State<DescBox> {
  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: widget.desc);
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
          controller: controller,
          style: Styles.taskStyle(18.0),
          keyboardType: TextInputType.multiline,
          maxLines: 5,
        ),
      ),
    );
  }
}

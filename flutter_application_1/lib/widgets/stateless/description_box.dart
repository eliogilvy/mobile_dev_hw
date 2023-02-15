import 'package:flutter/material.dart';

import '../../styles/styles.dart';

class DescriptionBox extends StatelessWidget {
  const DescriptionBox({super.key, required this.desc});

  final String desc;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(5)),
        child: Text(
          desc,
          style: Styles.taskStyle(18.0),
        ),
      ),
    );
  }
}

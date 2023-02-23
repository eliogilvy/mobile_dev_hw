import 'dart:io';

import 'package:flutter/material.dart';

class TaskImage extends StatelessWidget {
  TaskImage({super.key, required this.image});
  String image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 200, height: 200, child: Image.file(File(image)));
  }
}

import 'dart:io';

import 'package:flutter/material.dart';

class TaskImage extends StatelessWidget {
  TaskImage({super.key, required this.image});
  String image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 200, height: 200, child: Image.file(File(image)));
  }

  Widget getFile() {
    File? file;
    try {
      file = File(image);
      return Image.file(file);
    } catch (e) {
      return Container();
    }
  }
}

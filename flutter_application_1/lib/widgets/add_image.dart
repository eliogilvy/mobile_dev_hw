import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class AddImageContainer extends StatefulWidget {
  const AddImageContainer({super.key});

  @override
  State<AddImageContainer> createState() => _AddImageContainerState();
}

class _AddImageContainerState extends State<AddImageContainer> {
  final ImagePicker _picker = ImagePicker();
  late XFile? image;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: image != null ? Container() : Image.file(File(image!.path)),
    );
  }

  Future pickImage() async {
    try {
      image = await _picker.pickImage(source: ImageSource.gallery);

      if (image == null) {
        return;
      }
      final imageTemp = XFile(image!.path);
      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (e) {
      print("eror");
    }
  }
}

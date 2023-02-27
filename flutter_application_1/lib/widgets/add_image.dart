import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/classes/app_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../classes/db_provider.dart';
import '../classes/task.dart';

class ImageButton extends StatelessWidget {
  ImageButton({super.key, required this.task, required this.callback});
  Task task;
  Function callback;

  @override
  Widget build(BuildContext context) {
    var appInfo = Provider.of<AppProvider>(context);
    return IconButton(
        onPressed: () {
          _pickImage(appInfo);
        },
        icon: Icon(Icons.image));
  }

  void _pickImage(AppProvider appInfo) async {
    XFile? image;
    try {
      image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) {
        return;
      }
      task.image = image.path;
      appInfo.updateTask(task);
      callback();
    } on PlatformException catch (e) {
      print("error");
    }
  }
}

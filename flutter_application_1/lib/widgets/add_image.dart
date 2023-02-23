import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../classes/state_info.dart';
import '../classes/task.dart';

class ImageButton extends StatelessWidget {
  ImageButton({super.key, required this.task, required this.callback});
  Task task;
  Function callback;

  @override
  Widget build(BuildContext context) {
    var stateInfo = Provider.of<StateInfo>(context);
    return IconButton(
        onPressed: () {
          _pickImage(stateInfo);
        },
        icon: Icon(Icons.image));
  }

  void _pickImage(stateInfo) async {
    XFile? image;
    try {
      image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) {
        return;
      }
      task.image = image.path;
      stateInfo.updateTask(task);
      callback();
    } on PlatformException catch (e) {
      print("error");
    }
  }
}

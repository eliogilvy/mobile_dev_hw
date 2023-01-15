import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/styles/styles.dart';

class ShowTask extends StatelessWidget {
  const ShowTask({super.key, required this.task});

  final task;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      color: Styles.buttonBackground(),
      elevation: 30,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              task.title,
              style: Styles.titleStyle(Colors.black),
            ),
            SizedBox(height: 25.0),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Description: ${task.desc}",
                style: Styles.taskStyle(18.0),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: SizedBox(
                  child: Text(
                    "Status: ${task.status}",
                    style: Styles.taskStyle(18.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

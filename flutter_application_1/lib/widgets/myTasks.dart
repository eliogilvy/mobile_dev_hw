import 'package:flutter/material.dart';

class MyTasks extends StatefulWidget {
  final int counter;
  const MyTasks({required this.counter});

  @override
  State<MyTasks> createState() => _MyTasksState();
}

class _MyTasksState extends State<MyTasks> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Text(
        "My Tasks: ${widget.counter}",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30.0,
          fontFamily: "Jost",
        ),
      ),
    );
  }
}

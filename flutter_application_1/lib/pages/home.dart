import 'package:flutter/material.dart';
import '../widgets/myTasks.dart';
import '../styles/styles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MyTasks();
  }
}

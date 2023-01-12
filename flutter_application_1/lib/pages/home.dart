import 'package:flutter/material.dart';
import '../widgets/myTasks.dart';
import '../styles/styles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.myBackground(),
      appBar: Styles.myAppBar("Eli Ogilvy"),
      body: MyTasks(
        counter: _counter,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/newTask');
        },
        backgroundColor: Color.fromARGB(255, 247, 242, 157),
        child: Icon(
          Icons.create,
          color: Color.fromARGB(255, 219, 18, 209),
        ),
      ),
    );
  }
}

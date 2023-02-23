import 'package:beamer/beamer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/stateless/qr_button.dart';
import '../classes/auth.dart';
import '../styles/styles.dart';
import '../widgets/filter_tasks.dart';
import '../widgets/task_list.dart';

class MyTasks extends StatefulWidget {
  const MyTasks({super.key});

  @override
  State<MyTasks> createState() => _MyTasksState();
}

class _MyTasksState extends State<MyTasks> with WidgetsBindingObserver {
  final User? user = Auth().user;
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        // Show a SnackBar after a delay of 1 second
        Future.delayed(
          Duration(seconds: 1),
          () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Tap and hold a task to generate a QR code!'),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('called');
    if (state == AppLifecycleState.resumed) {
      // Show a SnackBar when the app is resumed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Tap and hold a task to generate a QR code!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print(user!.displayName);
    return Scaffold(
      backgroundColor: Styles.myBackground(),
      appBar: Styles.myAppBar("Eli Ogilvy"),
      body: Container(
        margin: EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                QRButton(),
                Filter(key: Key('Filter'), callback: _refresh),
              ],
            ),
            TaskList(
              key: Key('Task list'),
              callback: _refresh,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Beamer.of(context).beamToNamed(
            '/new',
            data: ["Primary", null, _refresh],
          );
        },
        backgroundColor: Styles.buttonBackground(),
        child: Icon(
          Icons.create,
          color: Styles.myBackground(),
        ),
      ),
    );
  }

  _refresh() {
    setState(() {});
  }
}

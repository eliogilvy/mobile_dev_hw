import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/task_page.dart';
import 'package:flutter_application_1/pages/my_tasks.dart';
import 'package:flutter_application_1/pages/task_form.dart';

import '../classes/task.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final routerDelegate = BeamerDelegate(
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '/': (context, state, data) => MyTasks(key: UniqueKey()),
        '/new': (context, state, data) => TaskForm(
              data: data as List,
            ),
        '/task/:id': (context, state, data) {
          var list = data as List;
          Task task = list[0];
          var callback = list[1] as Function;
          return TaskPage(
            task: task,
            callback: callback,
          );
        }
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: routerDelegate,
      routeInformationParser: BeamerParser(),
      backButtonDispatcher: BeamerBackButtonDispatcher(
        delegate: routerDelegate,
        alwaysBeamBack: true,
      ),
    );
  }
}

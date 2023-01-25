import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/task_page.dart';
import 'package:flutter_application_1/pages/my_tasks.dart';
import 'package:flutter_application_1/widgets/form/task_form.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final routerDelegate = BeamerDelegate(
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '/': (context, state, data) => MyTasks(),
        '/new': (context, state, data) => TaskForm(
              data: data as List,
            ),
        '/task/:id': (context, state, data) {
          final int id = int.parse(state.pathParameters['id'] as String);
          return TaskPage(id: id);
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

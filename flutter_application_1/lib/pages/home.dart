import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/task_page.dart';
import 'package:flutter_application_1/pages/my_tasks.dart';
import 'package:flutter_application_1/pages/task_form.dart';

import '../classes/task.dart';

class Home extends StatelessWidget {
  Home({super.key, required this.routerDelegate});
  final BeamerDelegate routerDelegate;

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

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

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

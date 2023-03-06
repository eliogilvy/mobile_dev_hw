
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({super.key, required this.router});
  final RouterConfig<Object> router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,      
    );
  }
}

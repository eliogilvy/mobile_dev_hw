import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/state_info.dart';
import 'pages/home.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => StateInfo(),
        ),
      ],
      child: Home(),
    ),
  );
}

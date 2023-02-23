import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/state_info.dart';
import 'package:flutter_application_1/pages/my_tasks.dart';
import 'package:flutter_application_1/pages/task_form.dart';
import 'package:flutter_application_1/pages/task_page.dart';
import 'package:flutter_application_1/widgets/stateless/scan_qr.dart';
import 'classes/auth.dart';
import 'classes/task.dart';
import 'pages/home.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Auth().signInAnon();

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
        },
        '/scan': (context, state, data) {
          return ScanQR();
        }
      },
    ),
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => StateInfo(),
        ),
      ],
      child: Home(
        routerDelegate: routerDelegate,
      ),
    ),
  );
}

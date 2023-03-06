import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/app_provider.dart';
import 'package:flutter_application_1/classes/db_provider.dart';
import 'package:flutter_application_1/database/firebase_helper.dart';
import 'package:flutter_application_1/database/sql_db_helper.dart';
import 'package:flutter_application_1/pages/my_tasks.dart';
import 'package:flutter_application_1/pages/task_form.dart';
import 'package:flutter_application_1/pages/task_page.dart';
import 'package:flutter_application_1/widgets/stateless/scan_qr.dart';
import 'package:go_router/go_router.dart';
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

  final router = GoRouter(
    routes: [
      GoRoute(
        name: 'home',
        path: '/',
        builder: (context, state) => MyTasks(),
        routes: [
          GoRoute(
            name: 'new',
            path: 'new',
            builder: (context, state) => TaskForm(data: state.extra as List),
          ),
          GoRoute(
            name: 'task',
            path: 'task/:id',
            builder: (context, state) {
              var list = state.extra as List;
              return TaskPage(
                task: list[0] as Task,
                callback: list[1] as Function,
              );
            },
          ),
          GoRoute(
            name: 'scan',
            path: 'scan',
            builder: (context, state) => ScanQR(),
          )
        ],
      ),
    ],
  );

  final routerDelegate = BeamerDelegate(
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '/': (context, state, data) => MyTasks(),
        '/new': (context, state, data) => TaskForm(
              data: data as List,
            ),
        '/task/:id': (context, state, data) {
          var list = data as List;
          Task task = list[0];
          var callback = list[1] as Function;
          return BeamPage(
            key: ValueKey(task.id),
            type: BeamPageType.slideTransition,
            child: TaskPage(
              task: task,
              callback: callback,
            ),
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
          create: (context) => AppProvider(
            local: DBProvider(helper: SQLDatabaseHelper()),
            shared: DBProvider(helper: FireBaseHelper()),
          ),
        ),
      ],
      child: Home(
        router: router,
      ),
    ),
  );
}

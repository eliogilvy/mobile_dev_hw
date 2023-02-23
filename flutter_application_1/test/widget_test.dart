import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/state_info.dart';
import 'package:flutter_application_1/classes/task.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/pages/my_tasks.dart';
import 'package:flutter_application_1/pages/task_form.dart';
import 'package:flutter_application_1/pages/task_page.dart';
import 'package:flutter_application_1/widgets/stateless/task_tile.dart';
import 'package:flutter_application_1/widgets/task_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'mock_db_helper.dart';
import 'mock_provider.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  tearDown(() async {
    MockDatabaseHelper.deleteAll();
  });

  // This test is
  testWidgets("Check that there are no tasks in the list at startup",
      (tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(testWidget());

      final nameFinder = find.text('Eli Ogilvy');
      expect(nameFinder, findsOneWidget);

      // Find the listview for tasks
      final listViewFinder = find.byType(TaskList);
      expect(listViewFinder, findsOneWidget);

      // // Find the task tile, but should find none
      final itemFinder = find.byType(TaskTile);
      expect(itemFinder, findsNothing);
    });
  });

  testWidgets(
      'This test confirms the following: A button that when clicked tells beamer '
      'to go to /task/id, shows a separate widget for each task when there are '
      'multiple tasks in th list, Indicates the name of the task, shows only '
      'some of the tasks when a filter is applied.', (tester) async {
    await tester.pumpWidget(testWidget());
    await addTask(tester, 'Test1', 'Open');
    await addTask(tester, 'Test2', 'In Progress');

    // These are also tests for adding a task

    final titleFinder = find.text('Eli Ogilvy');
    expect(titleFinder, findsOneWidget);

    // Verify multiple task tiles
    final tileCheck = find.byType(TaskTile);
    expect(tileCheck, findsNWidgets(2));

    // // Verify both tiles have the correct titles
    var titleTextFinder =
        find.descendant(of: tileCheck.first, matching: find.byType(Text));
    expect(titleTextFinder, findsOneWidget);

    titleTextFinder =
        find.descendant(of: tileCheck.last, matching: find.byType(Text));
    expect(titleTextFinder, findsOneWidget);

    // // Tap the filter icon and set top open, list should be length 1 now
    final filterFinder = find.byKey(Key('Filter'));
    expect(filterFinder, findsOneWidget);
    await tester.tap(filterFinder);
    await tester.pumpAndSettle();

    await tester.tap(find.text("Open"));
    await tester.pumpAndSettle();

    final tileFinder = find.byType(TaskTile);
    expect(tileFinder, findsOneWidget);
  });

  testWidgets(
      'This test confirms the following: Produces a task whose title and '
      'description match the ones entered by the user, also verifies edit buttons'
      'and proper updating of the task', (tester) async {
    await tester.pumpWidget(testWidget());

    await addTask(tester, 'Test1', 'Open');

    Finder titleFinder = find.text("Test1");
    expect(titleFinder, findsOneWidget);

    await tester.tap(titleFinder);
    await tester.pumpAndSettle();

    Finder descFinder = find.text("Desc test");
    final statusFinder = find.text("Open");
    final taskTypeFinder = find.text("Primary");

    expect(descFinder, findsOneWidget);
    expect(statusFinder, findsOneWidget);
    expect(taskTypeFinder, findsOneWidget);

    final editFinder = find.byIcon(Icons.edit).first;
    await tester.tap(editFinder);
    await tester.pumpAndSettle();

    final titleFieldFinder = find.byKey(Key("Edit title"));
    await tester.enterText(titleFieldFinder, "Updated title");

    final descFieldFinder = find.byKey(Key("Edit desc"));
    await tester.enterText(descFieldFinder, "Updated desc");

    await tester.tap(find.byIcon(Icons.check));
    await tester.pumpAndSettle();

    titleFinder = find.text("Updated title");
    descFinder = find.text("Updated desc");

    expect(titleFinder, findsOneWidget);
    expect(descFinder, findsOneWidget);
  });
}

Widget testWidget() {
  var routerDelegate = BeamerDelegate(
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
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<StateInfo>(
        create: (_) => MockStateInfo(),
      ),
    ],
    child: Home(
      routerDelegate: routerDelegate,
    ),
  );
}

Future addTask(WidgetTester tester, String message, String choice) async {
  var buttonFinder = find.byType(FloatingActionButton);
  await tester.tap(buttonFinder);
  await tester.pumpAndSettle();

  final nameField = find.byKey(Key("title"));
  final descField = find.byKey(Key("desc"));
  final dropDown = find.byKey(Key("dropdown"));

  expect(nameField, findsOneWidget);
  expect(descField, findsOneWidget);
  expect(dropDown, findsOneWidget);

  await tester.enterText(nameField, message);
  await tester.enterText(descField, "Desc test");

  final optionFinder = find.text("In Progress");
  expect(optionFinder, findsOneWidget);

  await tester.tap(dropDown);
  await tester.pumpAndSettle();
  await tester.tap(find.text(choice).last);
  await tester.pumpAndSettle();

  expect(find.text(message), findsOneWidget);
  expect(find.text("Desc test"), findsOneWidget);

  buttonFinder = find.byType(ElevatedButton);
  expect(buttonFinder, findsOneWidget);
  await tester.tap(buttonFinder);
  await tester.pumpAndSettle();
}

Task get testTask => Task(
      title: "Test",
      desc: 'Desc',
      status: 'Open',
      lastUpdate: DateTime.now(),
      related: {},
      taskType: 'Primary',
      lastFilter: '',
    );

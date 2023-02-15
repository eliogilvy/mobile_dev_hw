import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/state_info.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/pages/task_form.dart';
import 'package:flutter_application_1/widgets/stateless/task_tile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  // This test is
  testWidgets("Check that there are no tasks in the list at startup",
      (tester) async {
    await tester.pumpWidget(testWidget());

    // Find the listview for tasks
    final listViewFinder = find.byType(ListView);
    expect(listViewFinder, findsOneWidget);

    // // Find the task tile, but should find none
    final itemFinder = find.byType(TaskTile);
    expect(itemFinder, findsNothing);
  });

  testWidgets(
      'This test confirms the following: A button that when clicked tells the'
      'navigator/router to go to the widget for creating a new task, shows a'
      'separate widget for each task when there are tasks to list, Indicates'
      'the name of the task, shows only some of the tasks when a filter is applied.',
      (tester) async {
    await tester.pumpWidget(testWidget());

    // These are also tests for adding a task
    await addTask(tester, "Test1", "Open");
    await addTask(tester, "Test2", "In Progress");

    // Verify multiple task tiles
    final tileCheck = find.byType(TaskTile);
    expect(tileCheck, findsNWidgets(2));

    // Verify both tiles have the correct titles
    var titleTextFinder =
        find.descendant(of: tileCheck.first, matching: find.byType(Text));
    expect(titleTextFinder, findsOneWidget);

    titleTextFinder =
        find.descendant(of: tileCheck.last, matching: find.byType(Text));
    expect(titleTextFinder, findsOneWidget);

    // Tap the filter icon and set top open, list should be length 1 now
    final filterFinder = find.byType(IconButton);
    expect(filterFinder, findsOneWidget);
    await tester.tap(filterFinder);
    await tester.pumpAndSettle();

    await tester.tap(find.text("Open"));
    await tester.pumpAndSettle();

    final tileFinder = find.byType(TaskTile);
    expect(tileFinder, findsOneWidget);
  });

  testWidgets(
      'This test confirms the following: Produces a task whose title and'
      'description match the ones entered by the user, also verifies edit buttons'
      'and proper updating of the task', (tester) async {
    await tester.pumpWidget(testWidget());

    await addTask(tester, "Title1", "Open");

    final taskFinder = find.byType(TaskTile);
    await tester.tap(taskFinder);
    await tester.pumpAndSettle();

    Finder titleFinder = find.text("Title1");
    Finder descFinder = find.text("Desc test");
    final statusFinder = find.text("Open");
    final taskTypeFinder = find.text("Primary");

    expect(titleFinder, findsOneWidget);
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
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => StateInfo(),
      ),
    ],
    child: Home(),
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
  await tester.tap(buttonFinder);
  await tester.pumpAndSettle();
}

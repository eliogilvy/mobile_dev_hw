import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/app_provider.dart';
import 'package:flutter_application_1/classes/db_provider.dart';
import 'package:flutter_application_1/classes/task.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mock_db_helper.dart';

class MockStateInfo extends Mock with ChangeNotifier implements AppProvider {
  List<Task>? _taskList;
  Map<int, Task> _tasks = {};
  List<Task> _relatedTasks = [];

  List<String> statusList = [
    "Open",
    "In Progress",
    "Closed",
  ];

  List<String> relationshipList = [
    "Subtask",
    "Dependency",
    "Alternative",
    "Optional",
    "Recurring",
    "Primary",
  ];

  Map<String, String> relationshipPluralList = {
    "Subtask": "Subtasks",
    "Dependency": "Dependencies",
    "Alternative": "Alternatives",
    "Optional": "Optional",
  };

  Map<String, String> relationshipMap = {
    "Subtask": "Primary",
    "Dependency": "Primary",
    "Recurring": "Recurring",
    "Optional": "Primary",
    "Alternative": "Alternative",
    "Primary": "Primary",
  };
  int _count = 0;

  // Non DB provider functions
  @override
  List<String> get status => statusList;
  @override
  List<String> get relationships => relationshipList;
  @override
  List<String> get pluralRelationships =>
      relationshipPluralList.values.toList();
  @override
  List<String> get relationshipsShortened =>
      relationshipPluralList.keys.toList();

  // DB helpers
  @override
  Future<List<Task>> get tasks async {
    if (_taskList == null) {
      return await MockDatabaseHelper.getTasks();
    } else {
      return _taskList!;
    }
  }

  @override
  Future<Task> getTask(List params) async =>
      await MockDatabaseHelper.getTask(params[0]);

  @override
  Future<String> addTask(List params) async {
    Task task = params[0];
    String id = await MockDatabaseHelper.createTask(task);
    print("task $id");
    notifyListeners();
    return id;
  }

  @override
  Future<List<Task>> filterTasks(String filter) async {
    _taskList = await MockDatabaseHelper.filterTasks(filter);
    return _taskList!;
  }

  @override
  void updateTask(List params) async {
    Task task = params[0];
    task.lastUpdate = DateTime.now();
    await MockDatabaseHelper.updateTask(task);
    notifyListeners();
  }

  @override
  void addRelationship(Task task, Task relatedTask, String relationship) async {
    relatedTask.related[task.id.toString()] = relationship;
    task.related[relatedTask.id.toString()] = relationshipMap[relationship]!;
    await MockDatabaseHelper.updateTask(relatedTask);
    await MockDatabaseHelper.updateTask(task);
    notifyListeners();
  }

  @override
  Future<List<Task>> getRelatedTasks(Task task, String relationship) async {
    print(task.related);
    List<String> related = [];
    task.related.forEach(
      (key, value) {
        if (value == relationship) {
          related.add(key);
        }
      },
    );
    return await MockDatabaseHelper.getRelatedTasksWithFilter(related);
  }

  @override
  Future<Task> getNewTask() async {
    return await MockDatabaseHelper.getLast();
  }

  @override
  List<String> relatedTaskDropdown() {
    return relationshipList
        .where((element) => element != "Primary" && element != "Recurring")
        .toList();
  }
}

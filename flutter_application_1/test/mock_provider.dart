import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/state_info.dart';
import 'package:flutter_application_1/classes/task.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mock_db_helper.dart';

class MockStateInfo extends Mock with ChangeNotifier implements StateInfo {
  List<Task>? _taskList;
  Map<int, Task> _tasks = {};
  List<Task> _relatedTasks = [];

  List<String> _status = [
    "Open",
    "In Progress",
    "Closed",
  ];

  List<String> _relationships = [
    "Subtask",
    "Dependency",
    "Alternative",
    "Optional",
    "Recurring",
    "Primary",
  ];

  Map<String, String> _relationshipPlural = {
    "Subtask": "Subtasks",
    "Dependency": "Dependencies",
    "Alternative": "Alternatives",
    "Optional": "Optional",
  };

  Map<String, String> _relationshipMap = {
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
  List<String> get status => _status;
  @override
  List<String> get relationships => _relationships;
  @override
  List<String> get pluralRelationships => _relationshipPlural.values.toList();
  @override
  List<String> get relationshipsShortened => _relationshipPlural.keys.toList();

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
  Future<Task> getTask(int id) async => await MockDatabaseHelper.getTask(id);

  //List<int> get relatedTasks => _relatedTasks;

  @override
  int get count => _count;

  @override
  void addTask(Task task) async {
    int id = await MockDatabaseHelper.createTask(task);
    print("task $id");
    notifyListeners();
  }

  @override
  Future<void> filterTasks(String filter) async {
    _taskList = await MockDatabaseHelper.filterTasks(filter);
    notifyListeners();
  }

  @override
  void updateTask(Task task) async {
    task.lastUpdate = DateTime.now();
    await MockDatabaseHelper.updateTask(task);
    notifyListeners();
  }

  @override
  void addRelationship(Task task, Task relatedTask, String relationship) async {
    relatedTask.related[task.id.toString()] = relationship;
    task.related[relatedTask.id.toString()] = _relationshipMap[relationship]!;
    await MockDatabaseHelper.updateTask(relatedTask);
    await MockDatabaseHelper.updateTask(task);
    notifyListeners();
  }

  @override
  Future<List<Task>> getRelatedTasks(Task task, String relationship) async {
    print(task.related);
    List<int> related = [];
    task.related.forEach(
      (key, value) {
        if (value == relationship) {
          related.add(int.parse(key));
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
    return _relationships
        .where((element) => element != "Primary" && element != "Recurring")
        .toList();
  }
}

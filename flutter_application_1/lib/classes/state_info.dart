import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/task_db_helper.dart';

import 'task.dart';

class StateInfo with ChangeNotifier {
  StateInfo() {
    //addTask(_test);
  }

  Task _test = Task(
    title: "Test",
    desc: "This is a test",
    status: "Open",
    lastUpdate: DateTime.now(),
    taskType: "Primary",
    related: {},
  );

  List<Task> _taskList = [];
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
  List<String> get status => _status;
  List<String> get relationships => _relationships;
  List<String> get pluralRelationships => _relationshipPlural.values.toList();
  List<String> get relationshipsShortened => _relationshipPlural.keys.toList();

  // DB helpers
  Future<List<Task>> get tasks async {
    if (_taskList.isEmpty) {
      return await TaskDatabaseHelper.getTasks();
    } else {
      return _taskList;
    }
  }

  Future<Task> getTask(int id) async => await TaskDatabaseHelper.getTask(id);

  //List<int> get relatedTasks => _relatedTasks;

  int get count => _count;

  void addTask(Task task) async {
    await TaskDatabaseHelper.createTask(task);
  }

  Future<void> filterTasks(String filter) async {
    await TaskDatabaseHelper.filterTasks(filter);
    notifyListeners();
  }

  void sortTasks() {
    _taskList.sort(
      (b, a) => a.lastUpdate.compareTo(b.lastUpdate),
    );
  }

  void tasksToList() {
    _taskList.clear();
    _taskList.addAll(
      _tasks.values.where(
        (element) => (element.taskType == "Primary" ||
            element.taskType == "Alternative" ||
            element.taskType == "Recurring"),
      ),
    );
    sortTasks();
    notifyListeners();
  }

  void updateTask(Task task) async {
    task.lastUpdate = DateTime.now();
    await TaskDatabaseHelper.updateTask(task);
    tasksToList();
  }

  Task getTaskFromMap(int id) {
    return _tasks.putIfAbsent(id, () => _test);
  }

  Task getTaskFromList(int index) {
    return _taskList[index];
  }

  void addRelationship(int relatedId, String relationship) async {
    Task relatedTask = await TaskDatabaseHelper.getTask(relatedId);
    Task task = await TaskDatabaseHelper.getLast();
    relatedTask.related[task.id.toString()] = relationship;
    task.related[relatedTask.id.toString()] = _relationshipMap[relationship]!;
    await TaskDatabaseHelper.updateTask(relatedTask);
    await TaskDatabaseHelper.updateTask(task);
  }

  Future<List<Task>> getRelatedTasks(Task task, String relationship) async {
    return await TaskDatabaseHelper.getRelatedTasksWithFilter(
        task, relationship);
  }

  List<String> relatedTaskDropdown() {
    return _relationships
        .where((element) => element != "Primary" && element != "Recurring")
        .toList();
  }
}

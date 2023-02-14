import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/task_db_helper.dart';

import 'task.dart';

class StateInfo with ChangeNotifier {
  StateInfo() {
    //addTask(_test);
  }

  Task _test = Task(
    id: 1,
    title: "Test",
    desc: "This is a test",
    status: "Open",
    lastUpdate: DateTime.now(),
    taskType: "Primary",
    related: {},
  );

  List<Task> _taskList = [];
  Map<int, Task> _tasks = {};
  List<int> _relatedTasks = [];

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

  int _id = 1;
  int _count = 0;

  // Non DB provider functions
  List<String> get status => _status;
  List<String> get relationships => _relationships;

  // DB helpers
  Future<List<Task>> get tasks async => await TaskDatabaseHelper.getTasks();

  Future<Task> getTask(int id) async => await TaskDatabaseHelper.getTask(id);

  //List<int> get relatedTasks => _relatedTasks;

  int get count => _count;

  void addTask(Task task) async {
    await TaskDatabaseHelper.createTask(task);
  }

  void sortTasks() {
    _taskList.sort(
      (b, a) => a.lastUpdate.compareTo(b.lastUpdate),
    );
  }

  void filterTasks(String status) {
    if (status != "") {
      _taskList = _tasks.values
          .where(
            (element) =>
                element.status == status &&
                (element.taskType == "Primary" ||
                    element.taskType == "Alternative" ||
                    element.taskType == "Recurring"),
          )
          .toList();
      sortTasks();
      notifyListeners();
    } else if (status == "") {
      tasksToList();
    } else {
      _taskList.clear();
      notifyListeners();
    }
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

  void updateTasks(int id, String status) {
    _tasks[id]?.status = status;
    _tasks[id]?.lastUpdate = DateTime.now();
    tasksToList();
  }

  Task getTaskFromMap(int id) {
    return _tasks.putIfAbsent(id, () => _test);
  }

  Task getTaskFromList(int index) {
    return _taskList[index];
  }

  void addRelationship(int id, int relatedId, relationship) {
    _tasks[id]?.related[relatedId] = _relationshipMap[relationship]!;
    _tasks[relatedId]?.related[id] = relationship;
    print("Title: ${_tasks[relatedId]?.title} subtask: ${_tasks[id]?.title}");
  }

  void removeTask(int id) {
    _tasks[id]?.related.forEach((key, value) {
      removeRelationship(key, id);
    });
    _tasks.remove(id);
    tasksToList();
  }

  void removeRelationship(int relatedId, int id) {
    _tasks[relatedId]?.related.remove(id);
  }

  List<int> getRelatedTasks(int id, String relationship) {
    if (relationship == "") {
      return [];
    }
    print("Clearing");
    _relatedTasks.clear();
    _tasks[id]?.related.forEach((key, value) {
      if (value == relationship) {
        print("adding $key");
        _relatedTasks.add(key);
      }
    });
    return _relatedTasks;
  }

  void clearRelatedTasks() {
    _relatedTasks.clear();
    print("Cleared");
    notifyListeners();
  }

  void setFilter(int id, String relationship) {
    getTaskFromMap(id).lastFilter = relationship;
    notifyListeners();
  }

  List<String> relatedTaskDropdown() {
    return _relationships
        .where((element) => element != "Primary" && element != "Recurring")
        .toList();
  }

  String? getPluralRelationship(String relationship) {
    if (!_relationshipPlural.containsKey(relationship)) {
      return null;
    }
    return _relationshipPlural[relationship];
  }
}

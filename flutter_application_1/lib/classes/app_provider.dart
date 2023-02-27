import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/classes/abstract_info.dart';
import 'package:flutter_application_1/classes/task.dart';

class AppProvider extends AbstractDBProvider with ChangeNotifier {
  AppProvider({required this.local, required this.shared});
  AbstractDBProvider local;
  AbstractDBProvider shared;
  List<Task>? _taskList;

  @override
  Future<void> addRelationship(
      Task task, Task relatedTask, String relationship) async {
    if (!task.shared) {
      await local.addRelationship(task, relatedTask, relationship);
    } else {
      await shared.addRelationship(task, relatedTask, relationship);
    }

    notifyListeners();
  }

  @override
  Future<String> addTask(Task task) async {
    String id;
    if (!task.shared) {
      id = await local.addTask(task);
    } else {
      id = await shared.addTask(task);
    }
    notifyListeners();
    return id;
  }

  Future<List<Task>> sharedOrLocal(Task task) async {
    if (!task.shared) {
      return await local.tasks;
    } else {
      return await shared.tasks;
    }
  }

  @override
  Future<List<Task>> filterTasks(String filter) async {
    var list1 = await local.filterTasks(filter);
    var list2 = await shared.filterTasks(filter);
    list1 += list2;
    _taskList = _filter(list1);
    return _taskList!;
  }

  List<Task> _filter(List<Task> list) {
    list.sort((a, b) => b.lastUpdate.compareTo(a.lastUpdate));
    return list;
  }

  @override
  Future<List<Task>> getRelatedTasks(Task task, String relationship) async {
    if (!task.shared) {
      return await local.getRelatedTasks(task, relationship);
    } else {
      return await shared.getRelatedTasks(task, relationship);
    }
  }

  @override
  Future<Task> getTask(Task task) async {
    if (!task.shared) {
      return await local.getTask(task);
    } else {
      return await shared.getTask(task);
    }
  }

  @override
  Future<List<Task>> get tasks async {
    if (_taskList == null) {
      return await filterTasks('');
    } else {
      return _taskList!;
    }
  }

  @override
  Future<void> updateTask(Task task) async {
    if (!task.shared) {
      local.updateTask(task);
    } else {
      shared.updateTask(task);
    }
    notifyListeners();
  }

  @override
  void deleteTask(Task task) async {
    if (!task.shared) {
      local.deleteTask(task);
    } else {
      shared.deleteTask(task);
    }
    notifyListeners();
  }
}

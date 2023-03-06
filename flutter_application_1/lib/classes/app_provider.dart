import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/abstract_info.dart';
import 'package:flutter_application_1/classes/task.dart';

class AppProvider extends AbstractDBProvider with ChangeNotifier {
  AppProvider({required this.local, required this.shared});
  AbstractDBProvider local;
  AbstractDBProvider shared;
  List<Task>? _taskList;
  String currentFilter = '';
  late final _streamController = StreamController<List<Task>>();

  Stream<List<Task>> get stream => _streamController.stream;

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
    currentFilter = filter;
    var list1 = await local.filterTasks(filter);
    var list2 = await shared.filterTasks(filter);
    list1 += list2;
    _taskList = _filter(list1);
    notifyListeners();
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
    _taskList ??= await filterTasks(currentFilter);
    return _taskList!;
  }

  @override
  Future<void> updateTask(Task task) async {
    if (!task.shared) {
      await local.updateTask(task);
    } else {
      await shared.updateTask(task);
    }
    _streamController.add(_taskList!);
    notifyListeners();
  }

  @override
  void deleteTask(Task task) async {
    if (!task.shared) {
      local.deleteTask(task);
    } else {
      shared.deleteTask(task);
    }
    _streamController.add(_taskList!);
    notifyListeners();
  }
}

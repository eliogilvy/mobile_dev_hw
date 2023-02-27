import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/abstract_info.dart';
import 'package:flutter_application_1/database/abstract_db_helper.dart';

import 'task.dart';

class DBProvider extends AbstractDBProvider {
  DBProvider({required this.helper});

  AbstractDBHelper helper;

  List<Task>? _taskList;

  // DB helpers
  @override
  Future<List<Task>> get tasks async {
    if (_taskList == null) {
      return await helper.getTasks();
    } else {
      return _taskList!;
    }
  }

  @override
  Future<Task> getTask(Task task) async => await helper.getTask(task.id);

  @override
  Future<String> addTask(Task task) async {
    String id = await helper.createTask(task);
    print("task $id");
    return id;
  }

  @override
  Future<List<Task>> filterTasks(String filter) async {
    _taskList = await helper.filterTasks(filter);
    return _taskList!;
  }

  @override
  Future<void> updateTask(Task task) async {
    task.lastUpdate = DateTime.now();
    await helper.updateTask(task);
  }

  @override
  Future<void> addRelationship(Task task, Task relatedTask, String relationship) async {
    relatedTask.related[task.id.toString()] = relationship;
    task.related[relatedTask.id.toString()] = relationshipMap[relationship]!;
    await helper.updateTask(relatedTask);
    await helper.updateTask(task);
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
    return await helper.getRelatedTasksWithFilter(related);
  }

  @override
  void deleteTask(Task task) async {
    return await helper.deleteTask(task.id);
  }
}

import 'dart:convert';

import 'package:flutter_application_1/database/task_db.dart';
import 'package:sqflite/sqflite.dart';

import '../classes/task.dart';

class TaskDatabaseHelper {
  static String tableName = "Task";

  static void drop() async {
    var database = await TaskDb.instance.database;
    database!.delete(tableName);
  }

  static Future<int> createTask(Task task) async {
    var database = await TaskDb.instance.database;
    return await database!.insert(
      tableName,
      {
        'title': task.title,
        'desc': task.desc,
        'status': task.status,
        'lastUpdate': task.lastUpdate.millisecondsSinceEpoch,
        'taskType': task.taskType,
        'related': jsonEncode(task.related),
        'lastFilter': task.lastFilter
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<Task> getLast() async {
    var database = await TaskDb.instance.database;
    List<Map> list =
        await database!.query(tableName, orderBy: 'id DESC', limit: 1);

    Task task = Task.fromMap(list.first);
    return task;
  }

  static Future<List<Task>> getTasks() async {
    var database = await TaskDb.instance.database;
    List<Map> list = await database!.query(
      tableName,
      where: 'taskType = ? OR taskType = ? OR taskType = ?',
      whereArgs: ['Primary', 'Recurring', 'Alternative'],
      orderBy: 'lastUpdate DESC',
    );

    List<Task> tasks = [];

    for (var element in list) {
      var task = Task.fromMap(element);
      tasks.add(task);
    }

    return tasks;
  }

  static Future<Task> getTask(int id) async {
    var database = await TaskDb.instance.database;
    var item = await database!.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    var task = Task.fromMap(item.first);
    return task;
  }

  static Future<List<Task>> getRelatedTasks(Task task) async {
    var database = await TaskDb.instance.database;
    List<Task> tasks = [];
    for (var relatedTask in task.related.keys) {
      var item = await database!.query(
        tableName,
        where: 'id = ?',
        whereArgs: [relatedTask],
      );

      tasks.add(Task.fromMap(item.first));
    }
    return tasks;
  }

  static Future<List<Task>> getRelatedTasksWithFilter(
      Task task, String relationship) async {
    List<Task> tasks = [];
    if (relationship != "") {
      var database = await TaskDb.instance.database;

      for (var rel in task.related.keys) {
        var item = await database!.query(
          tableName,
          where: 'id = ? AND taskType = ?',
          whereArgs: [rel, relationship],
        );
        if (item.isNotEmpty) {
          tasks.add(Task.fromMap(item.first));
        }
      }
    }
    return tasks;
  }

  static Future<void> updateTask(Task task) async {
    var database = await TaskDb.instance.database;
    await database!.update(
      tableName,
      {
        'title': task.title,
        'desc': task.desc,
        'status': task.status,
        'lastUpdate': task.lastUpdate.millisecondsSinceEpoch,
        'taskType': task.taskType,
        'related': jsonEncode(task.related),
        'lastFilter': task.lastFilter
      },
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  static Future<void> deleteTask(int id) async {
    var database = await TaskDb.instance.database;
    await database!.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<List<Task>> filterTasks(String filter) async {
    var database = await TaskDb.instance.database;
    List<Map> list = await database!
        .query(tableName, where: 'status = ?', whereArgs: [filter]);
    List<Task> tasks = [];

    for (var element in list) {
      var task = Task.fromMap(element);
      tasks.add(task);
    }

    return tasks;
  }
}

import 'dart:convert';

import 'package:flutter_application_1/classes/task.dart';
import 'package:flutter_application_1/database/task_db.dart';
import 'package:sqflite/sqflite.dart';

import 'mock_db.dart';

class MockDatabaseHelper {
  static String tableName = "Task";

  static void deleteAll() async {
    var database = await MockDb.instance.database;
    await database!.delete(tableName);
  }

  static Future<String> createTask(Task task) async {
    var database = await MockDb.instance.database;
    print('adding task');
    return await database!.insert(
      tableName,
      {
        'title': task.title,
        'desc': task.desc,
        'status': task.status,
        'lastUpdate': task.lastUpdate.millisecondsSinceEpoch,
        'taskType': task.taskType,
        'related': jsonEncode(task.related),
        'lastFilter': task.lastFilter,
        'image': task.image,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    ).toString();
  }

  static Future<Task> getLast() async {
    var database = await MockDb.instance.database;
    List<Map> list =
        await database!.query(tableName, orderBy: 'id DESC', limit: 1);

    Task task = Task.fromMap(list.first);
    return task;
  }

  static Future<List<Task>> getTasks() async {
    var database = await MockDb.instance.database;
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

  static Future<Task> getTask(String id) async {
    var database = await MockDb.instance.database;
    var item = await database!.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    var task = Task.fromMap(item.first);

    return task;
  }

  static Future<List<Task>> getRelatedTasks(Task task) async {
    var database = await MockDb.instance.database;
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

  static Future<List<Task>> getRelatedTasksWithFilter(List<String> list) async {
    List<Task> tasks = [];
    {
      for (String id in list) {
        tasks.add(await MockDatabaseHelper.getTask(id));
      }
    }
    return tasks;
  }

  static Future<void> updateTask(Task task) async {
    var database = await MockDb.instance.database;
    await database!.update(
      tableName,
      {
        'title': task.title,
        'desc': task.desc,
        'status': task.status,
        'lastUpdate': task.lastUpdate.millisecondsSinceEpoch,
        'taskType': task.taskType,
        'related': jsonEncode(task.related),
        'lastFilter': task.lastFilter,
        'image': task.image,
      },
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  static Future<void> deleteTask(String id) async {
    var database = await MockDb.instance.database;
    await database!.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<List<Task>> filterTasks(String filter) async {
    var database = await MockDb.instance.database;
    if (filter == "") {
      return await MockDatabaseHelper.getTasks();
    }
    List<Map> list = await database!.query(tableName,
        where: 'status = ? AND (taskType = ? OR taskType = ? OR taskType = ?)',
        whereArgs: [filter, 'Primary', 'Recurring', 'Alternative']);
    List<Task> tasks = [];

    for (var element in list) {
      var task = Task.fromMap(element);
      tasks.add(task);
    }

    return tasks;
  }
}

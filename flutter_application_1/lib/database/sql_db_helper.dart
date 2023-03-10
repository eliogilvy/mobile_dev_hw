import 'dart:convert';

import 'package:flutter_application_1/database/abstract_db_helper.dart';
import 'package:flutter_application_1/database/task_db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import '../classes/task.dart';

class SQLDatabaseHelper extends AbstractDBHelper {
  static String tableName = "Task";

  @override
  void drop() async {
    var database = await TaskDb.instance.database;
    database!.delete(tableName);
  }

  @override
  Future<String> createTask(Task task) async {
    var database = await TaskDb.instance.database;
    task.id = Uuid().v4();
    await database!.insert(
      tableName,
      {
        'id': task.id,
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
    );
    return task.id;
  }

  @override
  Future<List<Task>> getTasks() async {
    var database = await TaskDb.instance.database;
    List<Map<String, dynamic>> list = await database!.query(
      tableName,
      where: 'taskType = ? OR taskType = ? OR taskType = ?',
      whereArgs: ['Primary', 'Recurring', 'Alternative'],
      orderBy: 'lastUpdate DESC',
    );

    List<Task> tasks = [];

    for (var item in list) {
      var task = Task.fromMap(_intToBool(item));
      tasks.add(task);
    }

    return tasks;
  }

  @override
  Future<Task> getTask(String id) async {
    var database = await TaskDb.instance.database;
    var item = await database!.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    var task = Task.fromMap(_intToBool(item.first));

    return task;
  }

  @override
  Future<List<Task>> getRelatedTasks(Task task) async {
    var database = await TaskDb.instance.database;
    List<Task> tasks = [];
    for (var relatedTask in task.related.keys) {
      var item = await database!.query(
        tableName,
        where: 'id = ?',
        whereArgs: [relatedTask],
      );

      tasks.add(Task.fromMap(_intToBool(item.first)));
    }
    return tasks;
  }

  @override
  Future<List<Task>> getRelatedTasksWithFilter(List<String> list) async {
    List<Task> tasks = [];
    for (String id in list) {
      tasks.add(await getTask(id));
    }

    return tasks;
  }

  @override
  Future<void> updateTask(Task task) async {
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
        'lastFilter': task.lastFilter,
        'image': task.image,
      },
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  @override
  Future<void> deleteTask(String id) async {
    var database = await TaskDb.instance.database;
    var list =
        await database!.query(tableName, where: 'id = ?', whereArgs: [id]);
    Task task = Task.fromMap(list.first);
    for (var relatedId in task.related.keys) {
      Task t = await getTask(relatedId);
      t.related.remove(id);
      await updateTask(t);
    }

    await database.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<Task>> filterTasks(String filter) async {
    if (filter == "") {
      return await getTasks();
    }
    var database = await TaskDb.instance.database;
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

  Map<String, dynamic> _intToBool(Map<String, dynamic> map) {
    var newMap = Map<String, dynamic>.from(map);
    if (newMap['shared'] == 0) {
      newMap['shared'] = false;
    } else {
      newMap['shared'] = true;
    }
    return newMap;
  }
}

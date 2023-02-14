import 'package:flutter_application_1/database/task_db.dart';

import '../classes/task.dart';

class TaskDatabaseHelper {
  static String tableName = "Task";

  static Future<void> createTask(Task task) async {
    var database = await TaskDb.instance.database;
    await database!.insert(tableName, task.toMap());
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

  static Future<void> updateTask(Task task) async {
    var database = await TaskDb.instance.database;
    await database!.update(
      tableName,
      task.toMap(),
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
}

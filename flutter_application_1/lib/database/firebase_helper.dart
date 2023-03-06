import 'dart:convert';

import 'package:flutter_application_1/classes/task.dart';
import 'package:flutter_application_1/database/abstract_db_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseHelper extends AbstractDBHelper {
  var fb = FirebaseFirestore.instance.collection('tasks');
  @override
  Future<String> createTask(Task task) async {
    var map = task.toMap();
    map['related'] = jsonEncode(task.related);
    var newTask = await fb.add(_removeId(map));
    return newTask.id;
  }

  @override
  Future<void> deleteTask(String id) async {
    var list = await fb.get();
    for (var task in list.docs) {
      Task t = Task.fromMap(_addId(task.data(), task.id));
      t.related.remove(id);
      await updateTask(t);
    }

    await fb.doc(id).delete();
  }

  @override
  void drop() {
    print('hello');
  }

  @override
  Future<List<Task>> filterTasks(String filter) async {
    List<Task> tasks = [];
    QuerySnapshot<Map<String, dynamic>> list;
    if (filter == '') {
      list = await fb.where('taskType',
          whereIn: ['Primary', 'Recurring', 'Alternative']).get();
    } else {
      list = await fb.where('status', isEqualTo: filter).where('taskType',
          whereIn: ['Primary', 'Recurring', 'Alternative']).get();
    }
    for (var task in list.docs) {
      tasks.add(Task.fromMap(_addId(task.data(), task.id)));
    }
    return tasks;
  }

  @override
  Future<List<Task>> getRelatedTasks(Task task) async {
    List<Task> tasks = [];
    for (var relatedTask in task.related.keys) {
      var task = await fb.doc(relatedTask).get();
      tasks.add(Task.fromMap(_addId(task.data()!, task.id)));
    }
    return tasks;
  }

  @override
  Future<List<Task>> getRelatedTasksWithFilter(List<String> list) async {
    List<Task> tasks = [];

    for (String id in list) {
      var task = await fb.doc(id).get();
      tasks.add(Task.fromMap(_addId(task.data()!, id)));
    }
    return tasks;
  }

  @override
  Future<Task> getTask(String id) async {
    var task = await fb.doc(id).get();
    return Task.fromMap(_addId(task.data()!, id));
  }

  @override
  Future<List<Task>> getTasks() async {
    List<Task> tasks = [];
    var list = await fb.orderBy('lastUpdate', descending: true).get();
    for (var task in list.docs) {
      tasks.add(Task.fromMap(_addId(task.data(), task.id)));
    }
    return tasks;
  }

  @override
  Future<void> updateTask(Task task) async {
    final doc = fb.doc(task.id);
    final snapshot = await doc.get();
    if (!snapshot.exists) {
      print('doesn"t exist');
    }
    await doc.update(_removeId(task.toMap()));
  }

  Map<String, dynamic> _removeId(Map<String, dynamic> map) {
    map.remove('id');
    return map;
  }

  Map<String, dynamic> _addId(Map<String, dynamic> map, String id) {
    map['id'] = id;
    return map;
  }
}

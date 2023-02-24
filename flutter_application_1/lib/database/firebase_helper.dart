import 'package:flutter_application_1/classes/task.dart';
import 'package:flutter_application_1/database/abstract_db_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseHelper extends AbstractDBHelper {
  var fb = FirebaseFirestore.instance.collection('shared');
  @override
  Future<String> createTask(Task task) async {
    await fb.add(task.toMap());
    return task.id;
  }

  @override
  Future<void> deleteTask(String id) async {
    await fb.doc(id).delete();
  }

  @override
  void drop() {
    // TODO: implement drop
  }

  @override
  Future<List<Task>> filterTasks(String filter) {
    // TODO: implement filterTasks
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> getRelatedTasks(Task task) async {
    List<Task> tasks = [];
    for (var relatedTask in task.related.keys) {
      var item = await fb.doc(task.id.toString()).get();
      tasks.add(Task.fromMap(item.data()!));
    }
    return tasks;
  }

  @override
  Future<List<Task>> getRelatedTasksWithFilter(List<String> list) async {
    List<Task> tasks = [];

    for (String id in list) {
      var task = await fb.doc(id.toString()).get();
      tasks.add(Task.fromMap(task.data()!));
    }
    return tasks;
  }

  @override
  Future<Task> getTask(String id) async {
    var task = await fb.where('id', isEqualTo: id).get();
    return Task.fromMap(task.docs.first.data());
  }

  @override
  Future<List<Task>> getTasks() async {
    List<Task> tasks = [];
    var list = await fb.orderBy('lastUpdate', descending: true).get();
    for (var task in list.docs) {
      tasks.add(Task.fromMap(task.data()));
    }
    return tasks;
  }

  @override
  Future<void> updateTask(Task task) async {
    fb.doc(task.id.toString()).update(task.toMap());
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/classes/abstract_info.dart';
import 'package:flutter_application_1/classes/task.dart';

class AppProvider extends AbstractDBProvider with ChangeNotifier {
  AppProvider({required this.local, required this.shared});
  AbstractDBProvider local;
  AbstractDBProvider shared;
  List<Task>? _taskList;

  @override
  void addRelationship(Task task, Task relatedTask, String relationship) {
    local.addRelationship(task, relatedTask, relationship);
    notifyListeners();
  }

  @override
  Future<String> addTask(List params) async {
    String id;
    if (params[1] == true) {
      id = await local.addTask(params);
    } else {
      id = await shared.addTask(params);
    }
    notifyListeners();
    return id;
  }

  @override
  Future<List<Task>> filterTasks(String filter) async {
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
    return await local.getRelatedTasks(task, relationship);
  }

  @override
  Future<Task> getTask(List params) async {
    if (params[1]) {
      return await local.getTask(params);
    } else {
      return await shared.getTask(params);
    }
  }

  @override
  Future<List<Task>> get tasks async {
    if (_taskList == null) {
      return await filterTasks('');
    }
    else {
      return _taskList!;
    }
  }

  @override
  void updateTask(List params) {
    // TODO: implement updateTask
  }

  @override
  int deleteTask(String id) {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }
}

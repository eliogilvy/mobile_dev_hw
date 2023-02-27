import 'package:flutter_application_1/classes/task.dart';

abstract class AbstractDBProvider {
  final List<String> statusList = [
    "Open",
    "In Progress",
    "Closed",
  ];

  final List<String> relationshipList = [
    "Subtask",
    "Dependency",
    "Alternative",
    "Optional",
    "Recurring",
    "Primary",
  ];

  final Map<String, String> relationshipPluralList = {
    "Subtask": "Subtasks",
    "Dependency": "Dependencies",
    "Alternative": "Alternatives",
    "Optional": "Optional",
  };

  final Map<String, String> relationshipMap = {
    "Subtask": "Primary",
    "Dependency": "Primary",
    "Recurring": "Recurring",
    "Optional": "Primary",
    "Alternative": "Alternative",
    "Primary": "Primary",
  };
  // Non DB provider functions
  List<String> get status => statusList;
  List<String> get relationships => relationshipList;
  List<String> get pluralRelationships =>
      relationshipPluralList.values.toList();
  List<String> get relationshipsShortened =>
      relationshipPluralList.keys.toList();

  Future<List<Task>> get tasks;
  Future<Task> getTask(Task task);
  Future<String> addTask(Task task);
  Future<dynamic> filterTasks(String filter);
  void updateTask(Task task);
  void addRelationship(Task task, Task relatedTask, String relationship);
  Future<List<Task>> getRelatedTasks(Task task, String relationship);
  List<String> relatedTaskDropdown() {
    return relationshipList
        .where((element) => element != "Primary" && element != "Recurring")
        .toList();
  }

  void deleteTask(Task task);
}

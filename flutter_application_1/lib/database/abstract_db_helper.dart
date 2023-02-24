import '../classes/task.dart';

abstract class AbstractDBHelper {
  void drop();
  Future<String> createTask(Task task);
  Future<List<Task>> getTasks();
  Future<Task> getTask(String id);
  Future<List<Task>> getRelatedTasks(Task task);
  Future<List<Task>> getRelatedTasksWithFilter(List<String> list);
  Future<void> updateTask(Task task);
  Future<void> deleteTask(String id);
  Future<List<Task>> filterTasks(String filter);
}

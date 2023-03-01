import '../model/task.dart';

abstract class LocaleStorage {
  Future<void> addTask(Task task);

  Future<Task?> getTask(Task task);

  Future<void> deleteTask(Task task);

  Future<void> updateTask(Task task);

  Future<List<Task>> getAllTasks();
}

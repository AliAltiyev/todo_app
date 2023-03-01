import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_using/localstorage/loacle_storage.dart';
import 'package:hive_using/model/task.dart';

import '../utils/constants.dart';

class HiveLocaleStorage extends LocaleStorage {
  late Box<Task> _box;

  HiveLocaleStorage() {
    _box = Hive.box<Task>('tasks');
  }

  @override
  Future<void> addTask(Task task) async {
    await _box.put(task.id, task);
  }

  @override
  Future<bool> deleteTask(Task task) async {
    await task.delete();
    return true;
  }

  @override
  Future<List<Task>> getAllTasks() async {
    List<Task> allTasks = [];
    allTasks = _box.values.toList();
    if (allTasks.isNotEmpty) {
      allTasks.sort((Task a, Task b) => a.time.compareTo(b.time));
    }
    return allTasks;
  }

  @override
  Future<Task?> getTask(Task task) async {
    return _box.get(task.id);
  }

  @override
  Future<Task> updateTask(Task task) async {
    await task.save();
    return task;
  }
}

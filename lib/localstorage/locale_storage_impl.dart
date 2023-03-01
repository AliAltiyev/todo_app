import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_using/localstorage/loacle_storage.dart';
import 'package:hive_using/model/task.dart';

import '../utils/constants.dart';

class HiveLocaleStorage extends LocaleStorage {
  late Box<Task> _box;

  HiveLocaleStorage() {
    _box = Hive.box(boxName);
  }

  @override
  Future<void> addTask(Task task) async {
    await _box.put(task.id, task);
  }

  @override
  Future<void> deleteTask(Task task) async {
    await task.delete();
  }

  @override
  Future<List<Task>> getAllTasks() async {
    return _box.values.toList();
  }

  @override
  Future<Task?> getTask(Task task) async {
    return _box.get(task.id);
  }

  @override
  Future<void> updateTask(Task task) async {
    await task.save();
  }
}

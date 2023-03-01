import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  final String id;
  @HiveField(2)
  DateTime time;
  @HiveField(3)
  bool isCompleted;

  Task(
      {required this.name,
      required this.id,
      required this.time,
      required this.isCompleted});

  factory Task.create(String name, DateTime time) {
    return Task(
        name: name, id: const Uuid().v1(), time: time, isCompleted: false);
  }

  @override
  String toString() {
    return 'Task{name: $name, id: $id, time: $time, inCompleted: $isCompleted}';
  }
}

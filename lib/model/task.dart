import 'package:uuid/uuid.dart';

class Task {
  String name;
  final String id;
  final DateTime time;
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

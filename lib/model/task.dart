import 'package:uuid/uuid.dart';

class Task {
  final String name;
  final String id;
  final DateTime time;
  final bool inCompleted;

  Task(
      {required this.name,
      required this.id,
      required this.time,
      required this.inCompleted});

  factory Task.create(String name, DateTime time) {
    return Task(
        name: name, id: const Uuid().v1(), time: time, inCompleted: false);
  }

  @override
  String toString() {
    return 'Task{name: $name, id: $id, time: $time, inCompleted: $inCompleted}';
  }
}

import 'package:flutter/material.dart';
import 'package:hive_using/model/task.dart';
import 'package:intl/intl.dart';

class TaskItem extends StatefulWidget {
  Task task;

  TaskItem({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  final TextEditingController _taskController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _taskController.text = widget.task.name;
  }

  @override
  Widget build(BuildContext context) {
    final task = widget.task;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        elevation: 2,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: _listTile(task),
        ),
      ),
    );
  }

  ListTile _listTile(Task task) {
    return ListTile(
        trailing: Text(
          DateFormat('hh:mm').format(task.time),
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
        title: task.isCompleted
            ? Text(task.name,
                style: task.isCompleted
                    ? const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey)
                    : const TextStyle(decoration: TextDecoration.none))
            : TextField(
                textInputAction: TextInputAction.done,
                maxLines: null,
                controller: _taskController,
                decoration: const InputDecoration(border: InputBorder.none),
                onSubmitted: (newValue) {
                  if (newValue.length > 3) {
                    task.name = newValue;
                  }
                },
              ),
        subtitle: Text(task.time.toString()),
        leading: task.isCompleted
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    task.isCompleted = !task.isCompleted;
                  });
                },
                child: const CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
              )
            : GestureDetector(
                onTap: () {
                  setState(() {
                    task.isCompleted = true;
                  });
                },
                child: const CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
              ));
  }
}

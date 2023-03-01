import 'package:flutter/material.dart';
import 'package:hive_using/localstorage/loacle_storage.dart';
import 'package:hive_using/widgets/task_item.dart';

import '../di/application.dart';
import '../model/task.dart';

class TaskListView extends StatefulWidget {
  final List<Task> tasks;

  const TaskListView({Key? key, required this.tasks}) : super(key: key);

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  late final LocaleStorage _localeStorage;

  @override
  void initState() {
    super.initState();
    _localeStorage = Application.locator<LocaleStorage>();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        final task = widget.tasks[index];
        return Dismissible(
          background: Container(
            color: Colors.red,
            child: Row(
              children: const [
                Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                Text(
                  'Delete',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
          key: UniqueKey(),
          onDismissed: (element) async {
            setState(() {});
            widget.tasks.remove(task);
            await _localeStorage.deleteTask(task);
          },
          child: TaskItem(task: task),
        );
      },
      itemCount: widget.tasks.length,
    );
  }
}

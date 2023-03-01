import 'package:flutter/material.dart';
import 'package:hive_using/widgets/task_list_view.dart';

import '../model/task.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<Task> _taskList;

  CustomSearchDelegate(this._taskList);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query.isEmpty ? null : query = '';
          },
          icon: const Icon(
            Icons.cancel_rounded,
            color: Colors.grey,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Task> _tasks = _taskList
        .where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return _tasks.isNotEmpty
        ? TaskListView(tasks: _tasks)
        : const Center(
            child: Text('Nothing found'),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox();
  }
}

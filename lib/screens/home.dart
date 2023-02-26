import 'package:flutter/material.dart';
import 'package:hive_using/widgets/task_item.dart';
import 'package:time_picker_sheet/widget/sheet.dart';
import 'package:time_picker_sheet/widget/time_picker.dart';

import '../model/task.dart';
import '../utils/constants.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Task> tasks;

  @override
  void initState() {
    super.initState();
    tasks = [];
    tasks.add(Task.create('Write code', DateTime.now()));
    tasks.add(Task.create('Wake up', DateTime.now()));
    tasks.add(Task.create('Go to  gym', DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            kAppBArTitleText,
            style: kAppBarTitleStyle,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {
                _showTaskBottomSheet(context);
              },
              icon: const Icon(Icons.add),
            )
          ],
        ),
        body: tasks.isNotEmpty
            ? ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  final reversedTasks = tasks.reversed.toList();
                  final task = reversedTasks[index];
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
                    onDismissed: (element) {
                      setState(() {
                        tasks.removeAt(index);
                      });
                    },
                    child: TaskItem(task: task),
                  );
                },
                itemCount: tasks.length,
              )
            : const Center(
                child: Text('Today nothing to do'),
              ));
  }

  void _showTaskBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 500,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                      maxLength: null,
                      autofocus: true,
                      onSubmitted: (value) async {
                        if (value.length > 3) {
                          Navigator.of(context).pop();
                          var time = await _dateTime(context);
                          final task = Task.create(value.toString(), time!);
                          setState(() {
                            tasks.add(task);
                          });
                        } else {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              duration: const Duration(seconds: 2),
                              backgroundColor: Colors.deepPurple,
                              content: SizedBox(
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                child: const Text('You not entered task'),
                              )));
                        }
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Add Task'))
                ],
              ),
            ),
          );
        });
  }

  Future<DateTime?> _dateTime(BuildContext context) async {
    return await TimePicker.show<DateTime?>(
        context: context,
        dismissible: false,
        sheet: TimePickerSheet(
          sheetTitle: 'Select meeting schedule',
          minuteTitle: 'Minute',
          hourTitle: 'Hour',
          saveButtonText: 'Save',
          saveButtonColor: Colors.deepPurple,
          sheetCloseIconColor: Colors.deepPurple,
          hourTitleStyle: const TextStyle(color: Colors.deepPurple),
          minuteTitleStyle: const TextStyle(color: Colors.deepPurple),
          wheelNumberItemStyle: const TextStyle(
            color: Colors.deepPurple,
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hive_using/di/application.dart';
import 'package:hive_using/localstorage/loacle_storage.dart';
import 'package:hive_using/widgets/task_item.dart';

import '../model/task.dart';
import '../utils/constants.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late LocaleStorage _localeStorage;
  late List<Task> tasks;

  @override
  void initState() {
    super.initState();
    _localeStorage = Application.locator<LocaleStorage>();
    setState(() {});
    tasks = [];
    _getAllTasksFromDb();

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
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          final task = tasks[index];
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
              await _localeStorage.deleteTask(task);
            },
            child: TaskItem(task: task),
          );
        },
        itemCount: tasks.length,
      ),
    );
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
                  Expanded(
                    child: TextField(
                        maxLength: null,
                        autofocus: true,
                        onSubmitted: (value) async {
                          if (value.length > 3) {
                            Navigator.of(context).pop();
                            showDateTimePicker(value);
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
                            border: OutlineInputBorder(),
                            labelText: 'Add Task')),
                  )
                ],
              ),
            ),
          );
        });
  }

  void _getAllTasksFromDb() async {
    tasks = await _localeStorage.getAllTasks();
    setState(() {});

  }

  void showDateTimePicker(String taskName) async {
    await DatePicker.showTimePicker(context,
        showTitleActions: true,
        theme: const DatePickerTheme(
            headerColor: Colors.orange,
            backgroundColor: Colors.blue,
            itemStyle: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            doneStyle: TextStyle(color: Colors.white, fontSize: 16)),
        onConfirm: (date) async {
      final task = Task.create(taskName, date);
      tasks.add(task);
      await _localeStorage.addTask(task);
      setState(() {
      });
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }
}

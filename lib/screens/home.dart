import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hive_using/di/application.dart';
import 'package:hive_using/localstorage/loacle_storage.dart';
import 'package:hive_using/utils/translation_helper.dart';
import 'package:hive_using/widgets/search_delegate.dart';
import 'package:hive_using/widgets/task_list_view.dart';

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
  int currentPageIndex = 0;

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
              onPressed: () {
                _searchTask(context);
              },
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
        body: TaskListView(tasks: tasks));
  }

  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.sunny),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Business',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'School',
        ),
      ],
      currentIndex: currentPageIndex,
      selectedItemColor: Colors.deepPurpleAccent,
      onTap: (value) {
        switch (value) {
          case 0:
            // Navigator.of(context).pushNamed(routeName)
            break;
        }
        setState(() {
          currentPageIndex = value;
        });
      },
    );
  }

  //Show BottomSheet
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
                                  child:
                                      const Text('snackBarErrorMessage').tr(),
                                )));
                          }
                        },
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: 'textFieldLabelText'.tr())),
                  )
                ],
              ),
            ),
          );
        });
  }

  //Get All Tasks from HiveBox
  void _getAllTasksFromDb() async {
    tasks = await _localeStorage.getAllTasks();
    setState(() {});
  }

  //Show DateTimePicker
  void showDateTimePicker(String taskName) async {
    await DatePicker.showTimePicker(
      context,
      showSecondsColumn: false,
      showTitleActions: true,
      locale: TranslationHelper.getDeviceLanguage(context),
      theme: const DatePickerTheme(
          headerColor: Colors.transparent,
          backgroundColor: Colors.black,
          itemStyle: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          doneStyle: TextStyle(color: Colors.white, fontSize: 16)),
      onConfirm: (date) async {
        final task = Task.create(taskName, date);
        tasks.add(task);
        await _localeStorage.addTask(task);
        setState(() {});
      },
      currentTime: DateTime.now(),
    );
  }

  //Search Task
  void _searchTask(BuildContext context) async {
    await showSearch(context: context, delegate: CustomSearchDelegate(tasks));
    _getAllTasksFromDb();
  }
}

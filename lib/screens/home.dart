import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
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
      body: Column(),
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
                  TextField(
                      onSubmitted: (value) async {
                        if (value.length > 3) {
                          Navigator.of(context).pop();
                          var time = await TimePicker.show<DateTime?>(
                              context: context,
                              dismissible: false,
                              sheet: TimePickerSheet(
                                sheetTitle: 'Select meeting schedule',
                                minuteTitle: 'Minute',
                                hourTitle: 'Hour',
                                saveButtonText: 'Save',
                                saveButtonColor: Colors.deepPurple,
                                sheetCloseIconColor: Colors.deepPurple,
                                hourTitleStyle:
                                    const TextStyle(color: Colors.deepPurple),
                                minuteTitleStyle:
                                    const TextStyle(color: Colors.deepPurple),
                                wheelNumberItemStyle: const TextStyle(
                                  color: Colors.deepPurple,
                                ),
                              ));
                          final task = Task.create(value.toString(), time!);
                          debugPrint(task.toString());
                        } else {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              duration: const Duration(seconds: 2),
                              backgroundColor: Colors.deepPurple,
                              content: Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                child: Text('You not entered task'),
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
}

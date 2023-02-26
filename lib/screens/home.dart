import 'package:flutter/material.dart';

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
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Add Task'),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(onPressed: () {}, child: Text('save'))
                ],
              ),
            ),
          );
        });
  }
}

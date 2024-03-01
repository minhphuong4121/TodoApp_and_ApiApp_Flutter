import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom_todo_app/model/todo_model.dart';
import 'package:flutter_application_1/custom_todo_app/ui/header.dart';
import 'package:flutter_application_1/custom_todo_app/ui/list_view.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Center(child: Text('Todo App')),
        //   backgroundColor: const Color.fromARGB(255, 244, 221, 22),
        // ),
        body: Container(
            //color: Colors.red,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Header(),
                const SizedBox(
                  height: 20,
                ),
                Expanded(child: ListViewBody()),
              ],
            )));
  }
}

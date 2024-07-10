import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom_todo_app/db/service/auth_service.dart';
import 'package:flutter_application_1/custom_todo_app/model/todo_model.dart';
import 'package:flutter_application_1/custom_todo_app/ui/home/header.dart';
import 'package:flutter_application_1/custom_todo_app/ui/home/list_view.dart';
import 'package:flutter_application_1/custom_todo_app/ui/login/login_page.dart';
import 'package:flutter_application_1/custom_todo_app/util/dialog.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Todo App',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color.fromARGB(255, 244, 221, 22),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return MyDiaLog(
                          height: MediaQuery.sizeOf(context).height * 0.2,
                          funcFirstButton: () => Navigator.pop(context),
                          funcSecondButton: () async {
                            final bool googleAuth =
                                await AuthService().googleSignOut();
                            print(googleAuth);

                            if (!googleAuth) {
                              await AuthService().signOut();
                            }
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                                (route) => false);
                          },
                        );
                      });
                },
                icon: const Icon(Icons.logout))
          ],
        ),
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

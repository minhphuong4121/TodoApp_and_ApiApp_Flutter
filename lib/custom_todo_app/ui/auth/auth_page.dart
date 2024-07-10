import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/crypto_market/ui/home_screen.dart';
import 'package:flutter_application_1/custom_todo_app/bloc/todo_bloc.dart';
import 'package:flutter_application_1/custom_todo_app/ui/home/main_page.dart';
import 'package:flutter_application_1/custom_todo_app/ui/login/login_page.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              //User is logged in
              if (snapshot.hasData) {
                return Provider<TodoBloc2>(
                    create: (context) => TodoBloc2(), child: const MainPage());
              } //user is not logged in
              else {
                return const LoginPage();
              }
            }));
  }
}

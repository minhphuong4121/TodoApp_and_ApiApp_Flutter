// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/crypto_market/data/provider/crypto_provider.dart';
import 'package:flutter_application_1/crypto_market/ui/home_screen.dart';
import 'package:flutter_application_1/custom_todo_app/bloc/todo_bloc.dart';
import 'package:flutter_application_1/custom_todo_app/db/todo_database.dart';
import 'package:flutter_application_1/custom_todo_app/ui/main_page.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
          /* For Todo app */
          //     Provider<TodoBloc2>(
          //   create: (context) => TodoBloc2(),
          //   child: const MainPage(),
          // ),
          ChangeNotifierProvider(
        create: (context) => CryptoProvider(),
        child: const HomePage(),
      ),
    );
  }
}

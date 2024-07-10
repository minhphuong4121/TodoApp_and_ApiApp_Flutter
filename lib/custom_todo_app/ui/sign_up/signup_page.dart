// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/custom_todo_app/bloc/todo_bloc.dart';
import 'package:flutter_application_1/custom_todo_app/db/service/auth_service.dart';
import 'package:flutter_application_1/custom_todo_app/ui/home/main_page.dart';
import 'package:flutter_application_1/custom_todo_app/ui/login/login_page.dart';
import 'package:flutter_application_1/custom_todo_app/util/button.dart';
import 'package:flutter_application_1/custom_todo_app/util/snack_bar.dart';
import 'package:flutter_application_1/custom_todo_app/util/square_title.dart';
import 'package:flutter_application_1/custom_todo_app/util/text_field.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    pwdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myHeight = MediaQuery.sizeOf(context).height;
    final myWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: myHeight * 0.1 - 40,
            ),
            const Text(
              'SIGN UP',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: myHeight * 0.1 - 30,
            ),
            buildTextField(),
            SizedBox(
              height: myHeight * 0.1 - 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.black,
                    ),
                  ),
                  Text('Or continue with'),
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: myHeight * 0.1 - 60,
            ),
            SquareTitle(
              imagePath: 'assets/icon/google_icon.png',
              onTap: () => googleLogin(),
            ),
            SizedBox(
              height: myHeight * 0.07,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
                  style: TextStyle(fontSize: 16),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                      (route) => false,
                    );
                  },
                  child: const Text(
                    ' Log in',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }

  Widget buildTextField() {
    return Column(
      children: [
        MyTextField(
          content: 'User name',
          textEditingController: nameController,
        ),
        const SizedBox(
          height: 15,
        ),
        MyTextField(
          content: 'Email',
          textEditingController: emailController,
        ),
        const SizedBox(
          height: 15,
        ),
        MyTextField(
          content: 'Password',
          textEditingController: pwdController,
        ),
        const SizedBox(
          height: 15,
        ),
        const SizedBox(
          height: 25,
        ),
        MyButton(
          content: 'Sign up',
          onTap: signUpUsers,
        ),
      ],
    );
  }

  void signUpUsers() async {
    String res = await AuthService().signUpUser(
        name: nameController.text,
        email: emailController.text,
        password: pwdController.text);

    //if signUp is success, user has been created and navigate to the next screen
    //otherwise show the error message
    if (res == "Successfully added") {
      setState(() {
        isLoading = true;
      });
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) {
        return Provider<TodoBloc2>(
            create: (context) => TodoBloc2(), child: const MainPage());
      }), ((route) => false));
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      //show the error message
      showSnackBar(context, res);
    }
  }

  void googleLogin() async {
    String res = await AuthService().googleLogin();

    if (res == "Successfully Google logged in") {
      setState(() {
        isLoading = true;
      });
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) {
        return Provider<TodoBloc2>(
            create: (context) => TodoBloc2(), child: const MainPage());
      }), ((route) => false));
    } else {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, res);
    }
  }
}

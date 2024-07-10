import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/custom_todo_app/bloc/todo_bloc.dart';
import 'package:flutter_application_1/custom_todo_app/db/service/auth_service.dart';
import 'package:flutter_application_1/custom_todo_app/ui/home/main_page.dart';
import 'package:flutter_application_1/custom_todo_app/ui/login/forgot_password_page.dart';
import 'package:flutter_application_1/custom_todo_app/ui/sign_up/signup_page.dart';
import 'package:flutter_application_1/custom_todo_app/util/button.dart';
import 'package:flutter_application_1/custom_todo_app/util/snack_bar.dart';
import 'package:flutter_application_1/custom_todo_app/util/square_title.dart';
import 'package:flutter_application_1/custom_todo_app/util/text_field.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _pwdController.dispose();
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
              'LOG IN',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: myHeight * 0.1,
            ),
            buildTextField(),
            SizedBox(
              height: myHeight * 0.1,
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
                  "Don't have an account?",
                  style: TextStyle(fontSize: 16),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                      (route) => false,
                    );
                  },
                  child: const Text(
                    ' Sign up',
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
          content: 'Email',
          textEditingController: _emailController,
        ),
        const SizedBox(
          height: 15,
        ),
        MyTextField(
          content: 'Password',
          textEditingController: _pwdController,
        ),
        const SizedBox(
          height: 15,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ResetPwdPage();
            }));
          },
          child: Padding(
            padding: EdgeInsets.only(right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Text('Forgot password?')],
            ),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        MyButton(
          content: 'Log in',
          onTap: loginUsers,
        ),
      ],
    );
  }

  void loginUsers() async {
    String res = await AuthService()
        .loginUser(email: _emailController.text, password: _pwdController.text);

    //if Login is success, user has been created and navigate to the next screen
    //otherwise show the error message
    if (res == "Successfully logged in") {
      // setState(() {
      //   isLoading = true;
      // });
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) {
        return Provider<TodoBloc2>(
            create: (context) => TodoBloc2(), child: const MainPage());
      }), ((route) => false));
    } else {
      // setState(() {
      //   isLoading = false;
      // });
      //show the error message
      showSnackBar(context, res);
    }
  }

  void googleLogin() async {
    String res = await AuthService().googleLogin();

    if (res == "Successfully Google logged in") {
      // setState(() {
      //   isLoading = true;
      // });
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) {
        return Provider<TodoBloc2>(
            create: (context) => TodoBloc2(), child: const MainPage());
      }), ((route) => false));
    } else {
      // setState(() {
      //   isLoading = false;
      // });
      showSnackBar(context, res);
    }
  }


}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom_todo_app/db/service/auth_service.dart';
import 'package:flutter_application_1/custom_todo_app/util/button.dart';
import 'package:flutter_application_1/custom_todo_app/util/snack_bar.dart';
import 'package:flutter_application_1/custom_todo_app/util/text_field.dart';

class ResetPwdPage extends StatefulWidget {
  const ResetPwdPage({super.key});

  @override
  State<ResetPwdPage> createState() => _ResetPwdPageState();
}

class _ResetPwdPageState extends State<ResetPwdPage> {
  final TextEditingController _emailResetController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailResetController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter your email and we will send a password reset link',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 35,
            ),
            MyTextField(
              content: 'Email',
              textEditingController: _emailResetController,
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.1,
            ),
            MyButton(
              content: 'SEND',
              width: MediaQuery.sizeOf(context).width * 0.5,
              onTap: () => resetPassword(),
            )
          ],
        ));
  }

  void resetPassword() async {
    String res = await AuthService()
        .resetPassword(email: _emailResetController.text.trim());

    if (res == "Successfully reset password") {
      showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text(
                "Password reset link sent! Check your email",
                textAlign: TextAlign.center,
              ),
            );
          });
      _emailResetController.clear();
    } else {
      showSnackBar(context, res);
    }
  }
}

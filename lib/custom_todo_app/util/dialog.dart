import 'package:flutter/material.dart';

class MyDiaLog extends StatelessWidget {
  MyDiaLog(
      {super.key,
      this.width,
      this.height,
      this.contentFirstButton,
      this.contentSecondButton,
      this.firstButton,
      this.secondButton,
      this.funcFirstButton,
      this.funcSecondButton,
      this.colorFirstButton,
      this.colorSecondButton});

  final double? width;
  final double? height;
  final ElevatedButton? firstButton;
  final ElevatedButton? secondButton;
  final String? contentFirstButton;
  final String? contentSecondButton;
  final Function()? funcFirstButton;
  final Function()? funcSecondButton;
  final Color? colorFirstButton;
  final Color? colorSecondButton;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(255, 211, 184, 104),
          ),
          width: width,
          height: height,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Do you want to LOG OUT?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            colorFirstButton ?? Colors.red)),
                    onPressed: funcFirstButton,
                    child: Text(
                      contentFirstButton ?? 'Cancel',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            colorSecondButton ?? Colors.green)),
                    onPressed: funcSecondButton,
                    child: Text(
                      contentSecondButton ?? 'OK',
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}

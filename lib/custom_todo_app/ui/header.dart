import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom_todo_app/bloc/todo_bloc.dart';
import 'package:flutter_application_1/custom_todo_app/bloc/todo_event.dart';
import 'package:flutter_application_1/custom_todo_app/model/todo_model.dart';
import 'package:provider/provider.dart';

class Header extends StatefulWidget {
  Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  TextEditingController textEdit = TextEditingController();
  // ignore: non_constant_identifier_names
  final header_form_key = GlobalKey<FormState>();

  @override
  void dispose() {
    textEdit.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<TodoBloc2>(context);
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 237, 230, 22),
                  Color.fromARGB(255, 130, 205, 227)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Form(
              key: header_form_key,
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter content';
                  }
                  return null;
                },
                controller: textEdit,
                decoration: InputDecoration(
                  label: const Text(
                    'Enter content...',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 20.0),
                ),
                maxLines: 1,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        ElevatedButton.icon(
            onPressed: () {
              if (header_form_key.currentState!.validate()) {
                // If the form is valid, save in data

                bloc.event.add(AddEvent(textEdit.text));
                textEdit.clear();
              }
            },
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text(
              'Add',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[900],
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(
                  color: Colors.blue.shade800,
                  width: 2.0,
                ),
              ),
            ))
      ],
    );
  }
}

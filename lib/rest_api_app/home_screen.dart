import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/rest_api_app/model/user.dart';
import 'package:flutter_application_1/rest_api_app/model/user_dob.dart';
import 'package:flutter_application_1/rest_api_app/model/user_location.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> users = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: fetchData,
      ),
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Rest Api App',
            style: TextStyle(),
          ),
        ),
      ),
      body: Container(
          child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final color = users[index].gender.toString() == 'male'
                    ? Colors.blue[200]
                    : Colors.pink[200];

                return ListTile(
                  shape: const Border.symmetric(
                      horizontal: BorderSide(width: 1.5, color: Colors.white)),
                  tileColor: color,
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                        users[index].avatar!.thumbnail.toString()),
                  ),
                  title: Text(
                    users[index].fullName(),
                    style: const TextStyle(color: Colors.black),
                  ),
                  subtitle: Text(users[index].location!.country.toString()),
                );
              })),
    );
  }

  fetchData() async {
    print('start');
    final url = Uri.parse('https://randomuser.me/api/?results=100');
    final response = await http.get(url);
    final json = jsonDecode(response.body);
    final results = json['results'] as List<dynamic>;
    final transformed = results.map((e) {
      return User.fromMap(e);
    }).toList();

    setState(() {
      users = transformed;
    });

    print('complete');
  }
}

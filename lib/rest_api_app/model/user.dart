import 'package:flutter_application_1/rest_api_app/model/user_dob.dart';
import 'package:flutter_application_1/rest_api_app/model/user_location.dart';
import 'package:flutter_application_1/rest_api_app/model/user_picture.dart';

class User {
  final String? gender;
  final String? email;
  final String? phone;
  final String? nat;
  final String? cell;
  final UserName? userName;
  final UserDoB? dob;
  final UserLocation? location;
  final UserPic? avatar;

  User({
    this.nat,
    this.cell,
    this.gender,
    this.email,
    this.phone,
    this.userName,
    this.location,
    this.dob,
    this.avatar,
  });

  String fullName() {
    return '${userName!.title} ${userName!.first} ${userName!.last}';
  }

  factory User.fromMap(Map<String, dynamic> e) {
    final name = UserName(
      title: e['name']['title'],
      first: e['name']['first'],
      last: e['name']['last'],
    );
    final dob = UserDoB(
      age: e['dob']['age'],
      date: DateTime.parse(e['dob']['date']),
    );
    final location = UserLocation.fromMap(e['location']);

    final avatar = UserPic.fromMap(e['picture']);

    return User(
      cell: e['cell'],
      email: e['email'],
      gender: e['gender'],
      nat: e['nat'],
      phone: e['phone'],
      userName: name,
      dob: dob,
      location: location,
      avatar: avatar,
    );
  }
}

class UserName {
  final String? title;
  final String? first;

  final String? last;

  UserName({this.first, this.last, this.title});
}

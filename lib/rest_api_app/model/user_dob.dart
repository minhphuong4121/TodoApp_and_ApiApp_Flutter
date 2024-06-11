class UserDoB {
  final DateTime? date;
  final int? age;

  UserDoB({
    this.date,
    this.age,
  });

  factory UserDoB.fromMap(Map<String, dynamic> e) {
    return UserDoB(
      date: e['date'],
      age: e['age'],
    );
  }
}

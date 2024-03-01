import 'package:flutter_application_1/custom_todo_app/db/todo_database.dart';
import 'package:flutter_application_1/custom_todo_app/model/todo_model.dart';
import 'package:sqflite/sqflite.dart';

class TodoTableCustom {
  static const tableName = 'todoTableCustom';
  static var createTableQuery = '''
CREATE TABLE $tableName (
  id INTEGER PRIMARY KEY,
  content TEXT
)
''';

  static const dropTableQuery = '''
      DROP TABLE IF EXISTS $tableName
      ''';

  Future<int> insertTable(TodoModel todo) async {
    Database data = await TodoData.getInstance();

    return data.insert(
      tableName,
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> deleItem(TodoModel? todo) async {
    Database? data = await TodoData.getInstance();

    return data.delete(tableName, where: 'id =?', whereArgs: [todo!.id]);
  }

  Future<int> updateTable(TodoModel todo) async {
    print('update data');
    Database data = await TodoData.getInstance();

    final result = await data
        .update(tableName, todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
    return result;
  }

  Future<List<TodoModel>> getAllTodo() async {
    Database data = await TodoData.getInstance();
    List<Map<String, dynamic>> maps = await data.query(tableName);

    List<TodoModel> list = maps.map((e) => TodoModel.fromData(e)).toList(); 
    return list;
  }
}

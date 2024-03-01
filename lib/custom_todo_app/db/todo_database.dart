import 'package:flutter_application_1/custom_todo_app/db/todo_table_custom.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TodoData {
  static Database? _database;
  static const dbVersion = 1;
  static const dbName = 'todoCustom.db';

  static Future<Database> getInstance() async {
    _database ??= await openDatabase(
      /// use join to create path for db, then the path will be path/student.db
      join(await getDatabasesPath(), dbName),

      /// This function will be called in the first time database is created
      onCreate: (db, version) {
        return db.execute(TodoTableCustom.createTableQuery);
      },

      /// This version will use when you want to upgrade or downgrade the database
      version: dbVersion,
      singleInstance: true,
    ); 
    return _database!;
  }
}

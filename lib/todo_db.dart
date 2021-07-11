import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todew/models/todo.dart';
import 'dart:async';

class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    final database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'todew_database.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE todos(id INTEGER PRIMARY KEY, title TEXT, description TEXT)',
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
    return database;
  }

  Future<void> insertTodo(Todo todo) async {
    var dbClient = await db;
    await dbClient!.insert('todos', todo.toMap());
  }

  Future<List<Todo>> getAll() async {
    var dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient!.query('todos');

    return List.generate(maps.length, (index) {
      return Todo(
          id: maps[index]['id'],
          title: maps[index]['title'],
          description: maps[index]['description']
      );
    });
  }
}
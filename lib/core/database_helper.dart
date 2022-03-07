import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper with ChangeNotifier {
  DatabaseHelper() {
    database();
  }

  Future<Database> database() async {
    var _db = openDatabase(
      join(await getDatabasesPath(), 'todo.db'),
      onCreate: ((db, version) async {
        await db.execute(
            "CREATE TABLE tasks(id INTEGER, title TEXT, description TEXT)");
        await db.execute(
            "CREATE TABLE todos(id INTEGER, taskId INTEGER, title TEXT, isDone INTEGER)");
      }),
      version: 1,
    );
    notifyListeners();
    return _db;
  }

  Future<void> insertTask(
      {required int taskId,
      required String title,
      required String desc}) async {
    Database _db = await database();
    Map<String, Object?> values = {
      'id': taskId,
      'title': title,
      'description': desc,
    };
    _db.insert('tasks', values);
    notifyListeners();
  }

  Future<void> insertTodo({
    required int id,
    required int taskId,
    required String value,
    required int isDone,
  }) async {
    Database _db = await database();
    Map<String, Object?> values = {
      'id': id,
      'taskId': taskId,
      'title': value,
      'isDone': isDone,
    };
    _db.insert('todos', values);
    notifyListeners();
  }

  Future<List<Map<String, dynamic>>> getTasks() async {
    Database _db = await database();
    var res = await _db.query('tasks');
    notifyListeners();
    return res;
  }

  Future<List<Map<String, dynamic>>> getTodos() async {
    Database _db = await database();
    var res = await _db.query('todos');
    notifyListeners();
    return res;
  }

  Future<void> updateTasks(
      {required int id,
      required String title,
      required String description}) async {
    Database _db = await database();
    Map<String, Object?> toUpdate = {
      'title': title,
      'description': description,
    };
    _db.update('tasks', toUpdate, where: 'id=$id');
    notifyListeners();
  }

  Future<void> updateTodo({required int id, required int value}) async {
    Database _db = await database();
    await _db.execute("UPDATE todos SET isDone=$value where id=$id");
    notifyListeners();
  }

  Future<void> deleteTasks({required int id}) async {
    Database _db = await database();
    await _db.execute("DELETE FROM tasks where id=$id");
    notifyListeners();
  }

  Future<void> deleteTodo({required int id}) async {
    Database _db = await database();
    await _db.execute("DELETE FROM todos where id=$id");
  }
}

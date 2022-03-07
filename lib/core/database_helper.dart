import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/core/models/tasks.dart';

import 'models/todos.dart';

class DatabaseHelper {
  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'todo.db'),
      onCreate: ((db, version) async {
        await db.execute(
            "CREATE TABLE tasks(id INTEGER, title TEXT, description TEXT)");
        await db.execute(
            "CREATE TABLE todos(id INTEGER, taskId INTEGER, title TEXT, isDone int)");
      }),
      version: 1,
    );
  }

  Future<void> insertTask(
      {required int taskId,
      required String title,
      required String desc}) async {
    Database _db = await database();
    await _db.execute("INSERT INTO tasks VALUES($taskId,'$title','$desc')");
  }

  Future<void> insertTodo({
    required int id,
    required int taskId,
    required String value,
    required int isDone,
  }) async {
    Database _db = await database();
    await _db.execute("INSERT INTO todos VALUES($id,$taskId,'$value',$isDone)");
  }

  Future<List<Tasks>> getTasks() async {
    Database _db = await database();
    List<Map<String, dynamic>> taskMap = await _db.query('tasks');
    return List.generate(taskMap.length, (index) {
      return Tasks(
          taskId: taskMap[index]['id'],
          title: taskMap[index]['title'],
          description: taskMap[index]['description']);
    });
  }

  Future<List<Todos>> getTodos() async {
    Database _db = await database();
    List<Map<String, dynamic>> todoMap = await _db.query('todos');
    return List.generate(todoMap.length, (index) {
      return Todos(
          todoId: todoMap[index]['id'],
          taskId: todoMap[index]['taskId'],
          title: todoMap[index]['title'],
          isDone: todoMap[index]['isDone']);
    });
  }
}
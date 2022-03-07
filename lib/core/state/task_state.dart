import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:todo_app/core/database_helper.dart';
import 'package:todo_app/core/models/tasks.dart';

import '../models/todos.dart';

class TasksState with ChangeNotifier {
  final DatabaseHelper db = DatabaseHelper();

  Future<List<Tasks>> get tasks async => await db.getTasks();

  Future<List<Todos>> get todos async => await db.getTodos();

  Future<int> insertTask(
      {String? title, String? desc, String? todoValue}) async {
    if (title == "") {
      title = "Untitled";
    }
    if (desc == "") {
      desc = "No Description Added";
    }

    title ??= title = "Untitled";
    desc ??= desc = "No Description Added";
    int _taskId;
    if (tasks.isEmpty) {
      _taskId = 1;
    } else {
      _taskId = tasks.first.taskId + 1;
    }

    db.insertTask(taskId: _taskId, title: title, desc: desc);

    //Tasks newTasks = Tasks(taskId: _taskId, title: title, description: desc);
    //_tasks.insert(0, newTasks);

    if (todoValue != null) {
      int lastTodoId;
      if (todos.isEmpty) {
        lastTodoId = 1;
      } else {
        lastTodoId = todos.last.todoId + 1;
      }

      db.insertTodo(
          id: lastTodoId, taskId: _taskId, value: todoValue, isDone: 0);

      // Todos newTodo = Todos(
      //     todoId: lastTodoId, taskId: _taskId, title: todoValue, isDone: 0);
      // _todos.add(newTodo);
    }
    notifyListeners();
    return _taskId;
  }

  void updateTask(
      {required int id, required String title, required String description}) {
    final index = tasks.indexWhere((element) => element.taskId == id);

    log("Gelen id indeksi= " + index.toString());

    if (title == "") {
      title = "Untitled";
    }
    if (description == "") {
      description = "No Description Added";
    }

    tasks[index].title = title;
    tasks[index].description = description;

    log("Title: " + title);
    log("Subtitle: " + description);
    notifyListeners();
  }

  List<Todos> toRemove = [];
  void deleteTask(int id) {
    toRemove.clear();
    final index = tasks.indexWhere((x) => x.taskId == id);
    tasks.removeAt(index);
    for (var x in todos) {
      if (x.taskId == id) {
        final index = todos.indexWhere((element) => element.todoId == x.todoId);
        toRemove.add(todos[index]);
        //todos.removeAt(index);
        //log(x.todoId.toString() + " idli todo silindi.");
      }
    }
    todos.removeWhere((e) => toRemove.contains(e));
    log("Silinenler: " + toRemove.toString());
    log(index.toString() + " indexe ait task silindi.");
    notifyListeners();
  }

  List<Todos> matched = [];
  Future<List<Todos>> getTodo(int taskId) async {
    matched.clear();
    for (var x in todos) {
      if (x.taskId == taskId) {
        matched.add(x);
      }
    }

    return matched;
  }

  void addTodo({String? title, required int taskId}) {
    title ??= title = "Untitled";
    int lastTodoId;

    if (todos.isEmpty) {
      lastTodoId = 1;
    } else {
      lastTodoId = todos.last.todoId + 1;
    }

    // Todos newTodo =
    //     Todos(todoId: lastTodoId, taskId: taskId, title: title, isDone: false);
    //_todos.add(newTodo);
    notifyListeners();
  }

  void deleteTodo(int id) {
    final index = todos.indexWhere((element) => element.todoId == id);
    todos.removeAt(index);
    notifyListeners();
  }

  void updateTodoDone(int todoId) {
    final index = todos.indexWhere((element) => element.todoId == todoId);
    todos[index].isDone = !todos[index].isDone;
    notifyListeners();
  }
}

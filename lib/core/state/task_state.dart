import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:todo_app/core/database_helper.dart';
import 'package:todo_app/core/models/tasks.dart';

import '../models/todos.dart';

class TasksState with ChangeNotifier {
  final DatabaseHelper db = DatabaseHelper();

  List<Tasks> taskList = [];
  List<Todos> todoList = [];

  Future<List<Tasks>> fetchTasks() async {
    taskList = await db.getTasks();
    notifyListeners();
    return taskList;
  }

  Future<List<Todos>> fetchTodo() async {
    todoList = await db.getTodos();
    notifyListeners();
    return todoList;
  }

  //Future<List<Tasks>> get tasks async => await db.getTasks();

  //Future<List<Todos>> get todos async => await db.getTodos();

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
    fetchTasks();
    int _taskId;
    if (taskList.isEmpty) {
      _taskId = 1;
    } else {
      _taskId = taskList.first.taskId + 1;
    }

    db.insertTask(taskId: _taskId, title: title, desc: desc);

    //Tasks newTasks = Tasks(taskId: _taskId, title: title, description: desc);
    //_tasks.insert(0, newTasks);

    if (todoValue != null) {
      fetchTodo();
      int lastTodoId;
      if (todoList.isEmpty) {
        lastTodoId = 1;
      } else {
        lastTodoId = todoList.last.todoId + 1;
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
    final index = taskList.indexWhere((element) => element.taskId == id);

    log("Gelen id indeksi= " + index.toString());

    if (title == "") {
      title = "Untitled";
    }
    if (description == "") {
      description = "No Description Added";
    }

    db.updateTasks(
      id: id,
      title: title,
      description: description,
    );

    log("Title: " + title);
    log("Subtitle: " + description);
    notifyListeners();
  }

  List<Todos> toRemove = [];
  void deleteTask(int id) {
    toRemove.clear();
    db.deleteTasks(id: id);
    for (var x in todoList) {
      if (x.taskId == id) {
        final index =
            todoList.indexWhere((element) => element.todoId == x.todoId);
        toRemove.add(todoList[index]);
      }
    }
    for (var x in toRemove) {
      db.deleteTodo(id: x.todoId);
    }
    notifyListeners();
  }

  List<Todos> matched = [];
  Future<List<Todos>> getTodo(int taskId) async {
    matched.clear();
    for (var x in todoList) {
      if (x.taskId == taskId) {
        matched.add(x);
      }
    }

    return matched;
  }

  void addTodo({String? title, required int taskId}) {
    title ??= title = "Untitled";
    int lastTodoId;
    if (todoList.isEmpty) {
      lastTodoId = 1;
    } else {
      lastTodoId = todoList.last.todoId + 1;
    }

    db.insertTodo(
      id: lastTodoId,
      taskId: taskId,
      value: title,
      isDone: 0,
    );

    notifyListeners();
  }

  void deleteTodo(int id) {
    db.deleteTodo(id: id);
    notifyListeners();
  }

  void updateTodoDone(int todoId) {
    int value;
    final index = todoList.indexWhere((element) => element.todoId == todoId);
    if (todoList[index].isDone == 0) {
      value = 1;
    } else {
      value = 0;
    }

    db.updateTodo(
      id: todoId,
      value: value,
    );

    notifyListeners();
  }
}

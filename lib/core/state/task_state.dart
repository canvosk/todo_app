import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:todo_app/core/database_helper.dart';
import 'package:todo_app/core/models/tasks.dart';

import '../models/todos.dart';

class TasksState with ChangeNotifier {
  TasksState() {
    fetchAndSetTask();
    fetchAndSetTodo();
  }

  DatabaseHelper db = DatabaseHelper();
  List<Tasks> taskList = [];

  Future<void> fetchAndSetTask() async {
    final tasks = await db.getTasks();
    for (var x in tasks) {
      Tasks item = Tasks(
        id: x['id'],
        title: x['title'],
        description: x['description'],
      );
      taskList.insert(0, item);
    }

    notifyListeners();
  }

  List<Todos> todoList = [];

  Future<void> fetchAndSetTodo() async {
    final todos = await db.getTodos();
    for (var x in todos) {
      Todos item = Todos(
        id: x['id'],
        taskId: x['taskId'],
        title: x['title'],
        isDone: 0,
      );
      todoList.insert(0, item);
    }

    notifyListeners();
  }

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
    if (taskList.isEmpty) {
      _taskId = 1;
    } else {
      _taskId = taskList.first.id + 1;
    }

    Tasks item = Tasks(
      id: _taskId,
      title: title,
      description: desc,
    );
    taskList.insert(0, item);

    db.insertTask(taskId: _taskId, title: title, desc: desc);

    if (todoValue != null) {
      int lastTodoId;
      if (todoList.isEmpty) {
        lastTodoId = 1;
      } else {
        lastTodoId = todoList.last.id + 1;
      }

      Todos newTodo =
          Todos(id: lastTodoId, taskId: _taskId, title: todoValue, isDone: 0);
      todoList.add(newTodo);

      db.insertTodo(
          id: lastTodoId, taskId: _taskId, value: todoValue, isDone: 0);
    }
    notifyListeners();
    return _taskId;
  }

  void updateTask(
      {required int id, required String title, required String description}) {
    final index = taskList.indexWhere((element) => element.id == id);

    log("Gelen id indeksi= " + index.toString());

    if (title == "") {
      title = "Untitled";
    }
    if (description == "") {
      description = "No Description Added";
    }

    taskList[index].title = title;
    taskList[index].description = description;

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
    final index = taskList.indexWhere((element) => element.id == id);
    taskList.removeAt(index);

    db.deleteTasks(id: id);

    for (var x in todoList) {
      if (x.taskId == id) {
        final index = todoList.indexWhere((element) => element.id == x.id);
        toRemove.add(todoList[index]);
      }
    }

    for (var x in toRemove) {
      todoList.removeWhere((element) => toRemove.contains(element));
      db.deleteTodo(id: x.id);
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
      lastTodoId = todoList.last.id + 1;
    }

    Todos newTodo =
        Todos(id: lastTodoId, taskId: taskId, title: title, isDone: 0);
    todoList.add(newTodo);

    db.insertTodo(
      id: lastTodoId,
      taskId: taskId,
      value: title,
      isDone: 0,
    );
    notifyListeners();
  }

  void deleteTodo(int id) {
    final index = todoList.indexWhere((element) => element.id == id);
    todoList.removeAt(index);
    db.deleteTodo(id: id);
    notifyListeners();
  }

  void updateTodoDone(int todoId) {
    int value;
    final index = todoList.indexWhere((element) => element.id == todoId);
    if (todoList[index].isDone == 0) {
      value = 1;
    } else {
      value = 0;
    }

    todoList[index].isDone = value;

    db.updateTodo(
      id: todoId,
      value: value,
    );
    notifyListeners();
  }
}

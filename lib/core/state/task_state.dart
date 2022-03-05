import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:todo_app/core/models/tasks.dart';

import '../models/todos.dart';

class TasksState with ChangeNotifier {
  final List<Tasks> _tasks = [
    Tasks(
        taskId: 1,
        title: "Get Start!",
        description: "Hello Flutter.",
        degree: 4),
  ];

  List<Tasks> get tasks => _tasks;

  final List<Todos> _todos = [
    Todos(
        todoId: 1,
        taskId: 1,
        title: "First of all beleive ur self!",
        isDone: false),
    Todos(
      todoId: 2,
      taskId: 1,
      title: "Create a new task",
      isDone: false,
    ),
    Todos(
      todoId: 3,
      taskId: 1,
      title: "Create a new ToDo",
      isDone: false,
    ),
  ];

  List<Todos> get todos => _todos;

  Future<int> insertTask({String? title, String? desc, int? degree}) async {
    title ??= title = "Untitled";
    desc ??= desc = "No Description Added";

    degree ??= 4;

    int _taskId = tasks.first.taskId + 1;

    Tasks newTasks =
        Tasks(taskId: _taskId, title: title, description: desc, degree: degree);

    _tasks.insert(0, newTasks);
    log("Title: " + title);
    log("Subtitle: " + desc);
    notifyListeners();
    return _taskId;
  }

  void updateDegree({required int id, required int degree}) {
    tasks[id].degree = degree;
    log(id.toString() + "Idli taskin derecesi: " + degree.toString());
  }

  void updateTask(
      {required int id, required String title, required String description}) {
    final index = tasks.indexWhere((element) => element.taskId == id);

    log("Gelen id indeksi= " + index.toString());

    tasks[index].title = title;
    tasks[index].description = description;

    log("Title: " + title);
    log("Subtitle: " + description);
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
}

import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:todo_app/core/models/tasks.dart';

class TasksState with ChangeNotifier {
  final List<Tasks> _tasks = [
    Tasks(
        taskId: 0, title: "Get Start!", subtitle: "Hello Flutter.", degree: 4),
  ];

  List<Tasks> get tasks => _tasks;

  Future<int> insertTask({String? title, String? subtitle, int? degree}) async {
    title ??= title = "Untitled";
    subtitle ??= subtitle = "No Description Added";
    degree ??= 4;

    int _taskId = tasks.first.taskId + 1;

    Tasks newTasks = Tasks(
        taskId: _taskId, title: title, subtitle: subtitle, degree: degree);

    _tasks.insert(0, newTasks);
    log("Title: " + title);
    log("Subtitle: " + subtitle);
    notifyListeners();
    return _taskId;
  }

  void updateDegree({required int id, required int degree}) {
    tasks[id].degree = degree;
    log(id.toString() + "Idli taskin derecesi: " + degree.toString());
  }

  void updateSubtitle({required int id, String? title, String? subtitle}) {
    title ??= tasks[id].subtitle = subtitle;
    subtitle ??= tasks[id].title = title;

    // tasks[id].title = title;
    // tasks[id].subtitle = subtitle;

    // log("Title: " + title);
    // log("Subtitle: " + subtitle);
    notifyListeners();
  }
}

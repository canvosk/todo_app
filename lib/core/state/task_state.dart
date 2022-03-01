import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:todo_app/core/models/tasks.dart';

class TasksState with ChangeNotifier {
  final List<Tasks> _tasks = [
    Tasks(taskId: 0, title: "Get Start!", subtitle: "Hello Flutter."),
  ];

  List<Tasks> get tasks => _tasks;

  void insertTask({String? title, String? subtitle}) {
    title ??= title = "Untitled";
    subtitle ??= subtitle = "No Description Added";

    Tasks newTasks = Tasks(taskId: 0, title: title, subtitle: subtitle);

    _tasks.insert(0, newTasks);
    log("Title: " + title);
    log("Subtitle: " + subtitle);
    notifyListeners();
  }

  void updateTask({required int id, String? title, String? subtitle}) {
    title ??= tasks[id].subtitle = subtitle;
    subtitle ??= tasks[id].title = title;

    // tasks[id].title = title;
    // tasks[id].subtitle = subtitle;

    // log("Title: " + title);
    // log("Subtitle: " + subtitle);
    notifyListeners();
  }
}

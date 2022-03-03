import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:todo_app/core/models/tasks.dart';

class TasksState with ChangeNotifier {
  final List<Tasks> _tasks = [
    Tasks(
        taskId: 0,
        title: "Get Start!",
        description: "Hello Flutter.",
        degree: 4),
  ];

  List<Tasks> get tasks => _tasks;

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

  void updateSubtitle(
      {required int id, required String title, required String description}) {
    final index = tasks.indexWhere((element) => element.taskId == id);

    log("Gelen id indeksi= " + index.toString());

    tasks[index].title = title;
    tasks[index].description = description;

    log("Title: " + title);
    log("Subtitle: " + description);
    notifyListeners();
  }
}

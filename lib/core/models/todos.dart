class Todos {
  final int id;
  final int taskId;
  final String title;
  int isDone;

  Todos(
      {required this.id,
      required this.taskId,
      required this.title,
      required this.isDone});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taskId': taskId,
      'title': title,
      'isDone': isDone,
    };
  }
}

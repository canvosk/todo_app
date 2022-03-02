class Tasks {
  final int taskId;
  String? title;
  String? subtitle;
  //1 == Red Degree
  //2 == Yellow Degree
  //3 == Green Degree
  //4 == NonDegree
  int degree;

  Tasks(
      {required this.taskId, this.title, this.subtitle, required this.degree});
}

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/ui/components/inputs.dart';
import 'package:todo_app/ui/components/text.dart';
import 'package:todo_app/core/state/task_state.dart';
import 'package:todo_app/ui/widgets/widgets.dart';

import '../../core/models/tasks.dart';

class TaskPage extends StatefulWidget {
  final Tasks? sentedTask;
  const TaskPage({Key? key, this.sentedTask}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  TextEditingController title = TextEditingController();
  TextEditingController subtitle = TextEditingController();

  late FocusNode _titleFocus;
  late FocusNode _descriptionFocus;
  late FocusNode _todoFocus;
  bool sented = false;
  String _taskTitle = "";
  String _taskDesc = "";

  bool _contentVisile = false;
  int _taskId = 0;

  @override
  void initState() {
    if (widget.sentedTask != null) {
      _taskId = widget.sentedTask!.id;
      _taskTitle = widget.sentedTask!.title;
      _taskDesc = widget.sentedTask!.description;
      _contentVisile = true;
    }
    _titleFocus = FocusNode();
    _descriptionFocus = FocusNode();
    _todoFocus = FocusNode();

    super.initState();
  }

  void titleAction(var value, TasksState state) async {
    if (value != "") {
      if (_taskId == 0) {
        _taskId = await state.insertTask(title: value);
      } else {
        state.updateTask(
            id: _taskId, title: _taskTitle, description: _taskDesc);
      }
    }
    _descriptionFocus.requestFocus();
    setState(() {
      _taskTitle = value;
    });
  }

  void descAction(var value, TasksState state) async {
    if (value != "") {
      if (_taskId == 0) {
        if (_taskTitle != "") {
          _taskId = await state.insertTask(title: _taskTitle, desc: value);
        } else {
          _taskId = await state.insertTask(desc: value);
        }
      } else {
        state.updateTask(id: _taskId, title: _taskTitle, description: value);
        _taskDesc = value;
      }
      setState(() {
        _taskDesc = value;
      });
      _todoFocus.requestFocus();
    }
  }

  void todoAction(TasksState state, var value) async {
    if (_taskId != 0) {
      state.addTodo(
        title: value,
        taskId: _taskId,
      );
    } else {
      _taskId = await state.insertTask(
        title: _taskTitle,
        desc: _taskDesc,
        todoValue: value,
      );
    }
    _todoFocus.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksState>(
      builder: (context, state, a) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              margin: const EdgeInsets.all(0),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0, bottom: 6.0),
                        child: Row(
                          children: [
                            //
                            //
                            //
                            // Back Arrow
                            //
                            //
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(24.0),
                                child: Image(
                                  image: AssetImage(
                                      'assets/images/back_arrow_icon.png'),
                                ),
                              ),
                            ),
                            //
                            //
                            //
                            //Title Text Field
                            //
                            //
                            //
                            Expanded(
                              child: TextField(
                                focusNode: _titleFocus,
                                controller: TextEditingController()
                                  ..text = _taskTitle,
                                onChanged: (value) {
                                  _taskTitle = value;
                                },
                                onSubmitted: (value) async {
                                  titleAction(value, state);
                                },
                                decoration: titleTextField,
                                style: titleText,
                              ),
                            )
                          ],
                        ),
                      ),
                      //
                      //
                      //
                      //Desc Text Field
                      //
                      //
                      Visibility(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 12.0,
                          ),
                          child: TextField(
                            focusNode: _descriptionFocus,
                            controller: TextEditingController()
                              ..text = _taskDesc,
                            onChanged: (value) {
                              _taskDesc = value;
                            },
                            onSubmitted: (value) async {
                              descAction(value, state);
                            },
                            decoration: subtitleTextField,
                          ),
                        ),
                      ),
                      //
                      //
                      //ToDo List
                      //
                      //
                      FutureBuilder(
                        initialData: const [],
                        future: state.getTodo(_taskId),
                        builder: (context, snapshot) {
                          return Expanded(
                            child: ScrollConfiguration(
                              behavior: MyBehavior(),
                              child: ListView.builder(
                                itemCount: state.matched.length,
                                itemBuilder: (context, index) {
                                  return Slidable(
                                    key: UniqueKey(),
                                    endActionPane: ActionPane(
                                      extentRatio: 0.3,
                                      motion: const ScrollMotion(),
                                      dismissible: DismissiblePane(
                                        onDismissed: () {
                                          state.deleteTodo(
                                              state.matched[index].id);
                                        },
                                      ),
                                      children: [
                                        SlidableAction(
                                          onPressed: (context) {
                                            int _todoId =
                                                state.matched[index].id;
                                            _showDialog(
                                                context, state, _todoId, false);
                                          },
                                          backgroundColor:
                                              const Color(0xFFFE4A49),
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete,
                                        )
                                      ],
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        state.updateTodoDone(
                                            state.matched[index].id);
                                      },
                                      child: TodoWidget(
                                        text: state.matched[index].title,
                                        isDone: state.matched[index].isDone == 0
                                            ? false
                                            : true,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      //
                      //
                      //
                      //Enter ToDo Items Text Field
                      //
                      //
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
                            Container(
                              width: 20.0,
                              height: 20.0,
                              margin: const EdgeInsets.only(right: 12.0),
                              decoration: enterTodoDecoration,
                              child: const Image(
                                image:
                                    AssetImage('assets/images/check_icon.png'),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                focusNode: _todoFocus,
                                controller: TextEditingController()..text = "",
                                onSubmitted: (value) async {
                                  if (value.isNotEmpty) {
                                    todoAction(state, value);
                                  }
                                },
                                decoration: enterTodoTextField,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  //
                  //
                  //Delete Floating Button
                  //
                  //
                  //
                  Visibility(
                    visible: _contentVisile,
                    child: Positioned(
                      bottom: 24.0,
                      right: 24.0,
                      child: GestureDetector(
                        onTap: () {
                          if (_taskId != 0) {
                            _showDialog(context, state, _taskId, true);
                          }
                        },
                        child: const FloatingButton(
                            imagePath: "assets/images/delete_icon.png",
                            addGradient: false),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showDialog(BuildContext context, TasksState state, int id, bool task) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Do you want to delete?"),
            content: Container(
              margin: const EdgeInsets.symmetric(horizontal: 85.0),
              child: const FloatingButton(
                  imagePath: "assets/images/delete_icon.png",
                  addGradient: false),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      if (task == true) {
                        if (id != 0) {
                          state.deleteTask(id);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                      } else {
                        if (id != 0) {
                          state.deleteTodo(id);
                          Navigator.pop(context);
                        }
                      }
                    },
                    child: const Text("Yes"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("No"),
                  ),
                ],
              )
            ],
          );
        });
  }
}

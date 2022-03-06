import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/ui/components/inputs.dart';
import 'package:todo_app/ui/components/text.dart';
import 'package:todo_app/core/state/task_state.dart';
import 'package:todo_app/ui/widgets/widgets.dart';

import '../../core/models/tasks.dart';
import '../../core/models/todos.dart';

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
  List<Todos>? matched;

  bool _contentVisile = false;

  int _taskId = 0;

  @override
  void initState() {
    if (widget.sentedTask != null) {
      _taskId = widget.sentedTask!.taskId;
      _taskTitle = widget.sentedTask!.title;
      _taskDesc = widget.sentedTask!.description;
      _contentVisile = true;
    }
    _titleFocus = FocusNode();
    _descriptionFocus = FocusNode();
    _todoFocus = FocusNode();
    super.initState();
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
                            Expanded(
                              child: TextField(
                                focusNode: _titleFocus,
                                controller: TextEditingController()
                                  ..text = _taskTitle,
                                onChanged: (value) {
                                  _taskTitle = value;
                                },
                                onSubmitted: (value) async {
                                  if (value != "") {
                                    if (_taskId == 0) {
                                      _taskId =
                                          await state.insertTask(title: value);
                                    } else {
                                      state.updateTask(
                                          id: _taskId,
                                          title: _taskTitle,
                                          description: _taskDesc);
                                    }
                                  }
                                  _descriptionFocus.requestFocus();
                                  setState(() {
                                    _taskTitle = value;
                                  });
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
                      //degree side
                      //
                      //
                      Visibility(
                        //visible: _contentVisile,
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
                              if (value != "") {
                                if (_taskId == 0) {
                                  if (_taskTitle != "") {
                                    _taskId = await state.insertTask(
                                        title: _taskTitle, desc: value);
                                  } else {
                                    _taskId =
                                        await state.insertTask(desc: value);
                                  }
                                } else {
                                  state.updateTask(
                                      id: _taskId,
                                      title: _taskTitle,
                                      description: value);
                                  _taskDesc = value;
                                }
                                setState(() {
                                  _taskDesc = value;
                                });
                                _todoFocus.requestFocus();
                              }
                            },
                            decoration: subtitleTextField,
                          ),
                        ),
                      ),
                      //
                      //
                      //

                      FutureBuilder(
                        initialData: [],
                        future: state.getTodo(_taskId),
                        builder: (context, snapshot) {
                          return Expanded(
                            child: ListView.builder(
                              itemCount: state.matched.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    state.updateTodoDone(
                                        state.matched[index].todoId);
                                    // setState(() {});
                                  },
                                  child: TodoWidget(
                                    text: state.matched[index].title,
                                    isDone: state.matched[index].isDone == false
                                        ? false
                                        : true,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
                            Container(
                              width: 20.0,
                              height: 20.0,
                              margin: const EdgeInsets.only(right: 12.0),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                  color: const Color(0xFF86829D),
                                  width: 1.5,
                                ),
                              ),
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
                                  //setState(() {});
                                  _todoFocus.requestFocus();
                                },
                                decoration: const InputDecoration(
                                  hintText: "Enter Todo item...",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: _contentVisile,
                    child: Positioned(
                      bottom: 24.0,
                      right: 24.0,
                      child: GestureDetector(
                        onTap: () {
                          if (_taskId != 0) {
                            state.deleteTask(_taskId);
                            Navigator.pop(context);
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
}

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
  bool sented = false;
  String _taskTitle = "";
  String _taskDesc = "";
  List<Todos>? matched;

  bool _contentVisile = false;

  //1==red
  //2==yellow
  //3==green
  int taskId = 0;

  @override
  void initState() {
    if (widget.sentedTask != null) {
      taskId = widget.sentedTask!.taskId;
      _taskTitle = widget.sentedTask!.title;
      _taskDesc = widget.sentedTask!.description;
      _contentVisile = true;
    }
    _titleFocus = FocusNode();
    _descriptionFocus = FocusNode();
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
                                onSubmitted: (value) async {
                                  if (value != "") {
                                    if (taskId == 0) {
                                      taskId =
                                          await state.insertTask(title: value);
                                    } else {
                                      state.updateTask(
                                          id: taskId,
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
                            onSubmitted: (value) async {
                              if (value != "") {
                                if (taskId == 0) {
                                  taskId = await state.insertTask(desc: value);
                                } else {
                                  state.updateTask(
                                      id: taskId,
                                      title: _taskTitle,
                                      description: value);
                                  _taskDesc = value;
                                }
                              }
                            },
                            decoration: subtitleTextField,
                          ),
                        ),
                      ),
                      //
                      //
                      //

                      _contentVisile
                          ? FutureBuilder(
                              initialData: [],
                              future: state.getTodo(taskId),
                              builder: (context, snapshot) {
                                return Expanded(
                                  child: ListView.builder(
                                    itemCount: state.matched.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {},
                                        child: TodoWidget(
                                          text: state.matched[index].title,
                                          isDone: state.matched[index].isDone ==
                                                  false
                                              ? false
                                              : true,
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            )
                          : Container(),
                    ],
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

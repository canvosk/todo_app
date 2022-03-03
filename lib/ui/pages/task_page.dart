import 'dart:developer';

import 'package:flutter/material.dart';
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
  bool sented = false;
  String _taskTitle = "";
  String _taskDesc = "";

  //1==red
  //2==yellow
  //3==green
  int taskId = 0;

  @override
  void initState() {
    if (widget.sentedTask != null) {
      _taskTitle = widget.sentedTask!.title;
      _taskDesc = widget.sentedTask!.description;
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
                                    taskId =
                                        await state.insertTask(title: value);
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            child: const ChooseDegree(color: Colors.red),
                            onTap: () {
                              state.updateDegree(id: taskId, degree: 1);
                            },
                          ),
                          InkWell(
                            child: const ChooseDegree(color: Colors.yellow),
                            onTap: () {
                              state.updateDegree(id: taskId, degree: 2);
                            },
                          ),
                          InkWell(
                            child: const ChooseDegree(color: Colors.green),
                            onTap: () {
                              state.updateDegree(id: taskId, degree: 3);
                            },
                          ),
                        ],
                      ),
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
                            onSubmitted: (value) {
                              if (value != "") {
                                if (taskId != 0) {
                                  state.updateSubtitle(
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

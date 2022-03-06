import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/state/task_state.dart';
import 'package:todo_app/ui/components/colors.dart';
import 'package:todo_app/ui/components/text.dart';
import 'package:todo_app/ui/pages/task_page.dart';
import 'package:todo_app/ui/widgets/widgets.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TasksState>(
      builder: (context, state, a) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              color: mainPageBG,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Header(title: "ToDo`s"),
                      ScrollConfiguration(
                        behavior: MyBehavior(),
                        child: Expanded(
                          child: ListView.builder(
                            itemCount: state.tasks.length,
                            itemBuilder: (context, index) {
                              String? title, subtitle;
                              int? id;

                              title = state.tasks[index].title;
                              subtitle = state.tasks[index].description;
                              id = state.tasks[index].taskId;

                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TaskPage(
                                        sentedTask: state.tasks[index],
                                      ),
                                    ),
                                  );
                                },
                                child: TaskCardWidget(
                                  title: title,
                                  desc: subtitle,
                                  id: id,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 24.0,
                    right: 0.0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/task-page");
                      },
                      child: const FloatingButton(
                          imagePath: "assets/images/add_icon.png",
                          addGradient: true),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/state/task_state.dart';
import 'package:todo_app/ui/components/colors.dart';
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
                      //
                      //
                      //
                      // ToDo's Text
                      //
                      //
                      const Header(title: "ToDo`s"),
                      //
                      //
                      //
                      // List Tasks
                      //
                      //
                      Expanded(
                        child: ScrollConfiguration(
                          behavior: MyBehavior(),
                          child: ListView.builder(
                            itemCount: state.taskList.length,
                            itemBuilder: (context, index) {
                              String? title, subtitle;
                              int? id;

                              title = state.taskList[index].title;
                              subtitle = state.taskList[index].description;
                              id = state.taskList[index].id;

                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TaskPage(
                                        sentedTask: state.taskList[index],
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
                  //
                  //
                  //
                  // Add Floating Action Button
                  //
                  //
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

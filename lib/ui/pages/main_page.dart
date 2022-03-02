import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/state/task_state.dart';
import 'package:todo_app/ui/components/colors.dart';
import 'package:todo_app/ui/components/text.dart';
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
              color: mainPagedBG,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Header(title: "ToDo`s"),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.tasks.length,
                          itemBuilder: (context, index) {
                            String? title, subtitle;
                            int? id;

                            title = state.tasks[index].title;
                            subtitle = state.tasks[index].subtitle;
                            id = state.tasks[index].taskId;

                            return GestureDetector(
                              onTap: () {},
                              child: TaskCardWidget(
                                title: title,
                                desc: subtitle,
                                id: id,
                              ),
                            );
                          },
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
                      child: Container(
                        width: 60.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                          gradient: addButton,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: const Image(
                          image: AssetImage(
                            "assets/images/add_icon.png",
                          ),
                        ),
                      ),
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

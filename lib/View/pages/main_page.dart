import 'package:flutter/material.dart';
import 'package:todo_app/View/widgets/app_bar.dart';
import 'package:todo_app/View/widgets/main_page/main_page_body.dart';
import 'package:todo_app/View/widgets/scaffold.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyScaffold(
      appbar: MyAppBar(title: "ToDo's"),
      body: MainPageBody(),
    );
  }
}

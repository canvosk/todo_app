import 'package:flutter/material.dart';
import 'package:todo_app/View/widgets/add_page/add_page_body.dart';
import 'package:todo_app/View/widgets/app_bar.dart';
import 'package:todo_app/View/widgets/scaffold.dart';

class AddPage extends StatelessWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyScaffold(
      appbar: MyAppBar(
        title: "Add Page",
      ),
      body: AddPageBody(),
    );
  }
}

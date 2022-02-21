import 'package:flutter/material.dart';
import 'package:todo_app/View/components/style.dart';

class MyAppBar extends StatelessWidget {
  final Color backgroundColor = Colors.transparent;
  final String title;
  const MyAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      //toolbarHeight: 10,
      title: Text(
        title,
        style: appbarText,
      ),
      //systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }
}

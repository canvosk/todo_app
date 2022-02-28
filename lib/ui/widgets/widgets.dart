import 'package:flutter/material.dart';
import 'package:todo_app/ui/components/text.dart';

class Header extends StatelessWidget {
  final String title;
  const Header({Key? key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 32.0,
        bottom: 32.0,
      ),
      child: Text(
        title,
        style: header,
      ),
    );
  }
}

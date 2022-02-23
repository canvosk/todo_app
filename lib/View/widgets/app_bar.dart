import 'dart:developer';

import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/View/components/style.dart';
//import 'package:todo_app/View/components/style.dart';

class MyAppBar extends StatelessWidget {
  final Color backgroundColor = Colors.transparent;
  final String title;
  const MyAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String route = "/add-page";

    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      //toolbarHeight: 10,
      title: Container(
        margin: const EdgeInsets.symmetric(horizontal: 0),
        child: Text(title, style: appbarText),
      ),

      actions: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          //padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, route);
            },
            style: addButtonShape,
            child: Row(
              children: const [
                Icon(
                  Icons.add,
                  size: 24,
                  color: Colors.white,
                ),
                Text("Add New"),
              ],
            ),
          ),
        ),
      ],
      //systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }
}

//style: GoogleFonts.comfortaa(fontSize: 30)

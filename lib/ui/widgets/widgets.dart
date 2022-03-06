import 'package:flutter/material.dart';
import 'package:todo_app/ui/components/colors.dart';
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

class TaskCardWidget extends StatelessWidget {
  final String? title;
  final String? desc;
  final int? id;

  const TaskCardWidget({this.title, this.desc, this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 32.0,
        horizontal: 24.0,
      ),
      margin: const EdgeInsets.only(
        bottom: 20.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title",
            style: const TextStyle(
              color: Color(0xFF211551),
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
            ),
            child: Text(
              desc ?? "No Description Added",
              style: const TextStyle(
                fontSize: 16.0,
                color: Color(0xFF86829D),
                height: 1.5,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ChooseDegree extends StatelessWidget {
  final Color color;
  const ChooseDegree({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        // border: Border.all(
        //   width: 1,
        // ),
      ),
      width: 32,
      height: 32,
    );
  }
}

class TodoWidget extends StatelessWidget {
  final String text;
  final bool isDone;

  const TodoWidget({required this.text, required this.isDone});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 8.0,
      ),
      child: Row(
        children: [
          Container(
            width: 20.0,
            height: 20.0,
            margin: const EdgeInsets.only(
              right: 12.0,
            ),
            decoration: BoxDecoration(
                color: isDone ? const Color(0xFF7349FE) : Colors.transparent,
                borderRadius: BorderRadius.circular(6.0),
                border: isDone
                    ? null
                    : Border.all(color: const Color(0xFF86829D), width: 1.5)),
            child: const Image(
              image: AssetImage('assets/images/check_icon.png'),
            ),
          ),
          Flexible(
            child: Container(
              //width: double.infinity,
              margin: const EdgeInsets.all(0),
              child: Text(
                text,
                style: TextStyle(
                  color: isDone
                      ? const Color(0xFF211551)
                      : const Color(0xFF86829D),
                  fontSize: 16.0,
                  fontWeight: isDone ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Container(
//             alignment: Alignment.centerRight,
//             width: 15.0,
//             height: 15.0,
//             margin: const EdgeInsets.all(0),
//             child: const Image(
//               image: AssetImage("assets/images/delete_icon.png"),
//               color: Color.fromARGB(255, 163, 163, 163),
//             ),
//           ),

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class FloatingButton extends StatelessWidget {
  final String imagePath;
  final bool addGradient;
  const FloatingButton(
      {Key? key, required this.imagePath, required this.addGradient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.0,
      height: 60.0,
      decoration: BoxDecoration(
        gradient: addGradient ? addButton : null,
        color: addGradient ? null : deleteButton,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Image(
        image: AssetImage(imagePath),
      ),
    );
  }
}

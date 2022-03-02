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
            "$title  $id",
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

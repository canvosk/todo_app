import 'package:flutter/material.dart';

class MainPageBody extends StatelessWidget {
  const MainPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      child: const Center(
        child: Text("Hello"),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AddPageBody extends StatefulWidget {
  const AddPageBody({Key? key}) : super(key: key);

  @override
  State<AddPageBody> createState() => _AddPageBodyState();
}

class _AddPageBodyState extends State<AddPageBody> {
  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: const Center(
        child: Text("Merhaba"),
      ),
    );
  }
}

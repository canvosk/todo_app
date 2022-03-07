import 'package:flutter/material.dart';

const InputDecoration titleTextField = InputDecoration(
  hintText: "Enter Task Title",
  border: InputBorder.none,
);

const InputDecoration subtitleTextField = InputDecoration(
  hintText: "Enter Description for the task...",
  border: InputBorder.none,
  contentPadding: EdgeInsets.symmetric(
    horizontal: 24.0,
  ),
);

const InputDecoration enterTodoTextField = InputDecoration(
  hintText: "Enter Todo item...",
  border: InputBorder.none,
);

BoxDecoration enterTodoDecoration = BoxDecoration(
  color: Colors.transparent,
  borderRadius: BorderRadius.circular(6.0),
  border: Border.all(
    color: const Color(0xFF86829D),
    width: 1.5,
  ),
);

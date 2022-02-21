import 'package:flutter/material.dart';

class MyScaffold extends StatelessWidget {
  final Widget appbar;
  final Widget body;
  const MyScaffold({Key? key, required this.appbar, required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        appBar: PreferredSize(
          child: appbar,
          preferredSize: const Size.fromHeight(55),
        ),
        body: body,
      ),
    );
  }
}

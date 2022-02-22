import 'package:flutter/material.dart';
import 'View/pages/main_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Practice English',
      initialRoute: "/",
      routes: {
        "/": (context) => const MainPage(),
        // "/test-page": (context) => const TestPage(),
        // "/list-page": (context) => const ListPage(),
        // "/fav-page": (context) => const FavPage(),
      },
    );
  }
}

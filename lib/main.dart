import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/ui/pages/main_page.dart';
import 'package:todo_app/ui/pages/task_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.nunitoSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      title: 'Practice English',
      initialRoute: "/",
      routes: {
        "/": (context) => const MainPage(),
        "/task-page": (context) => const TaskPage(),
        // "/list-page": (context) => const ListPage(),
        // "/fav-page": (context) => const FavPage(),
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:todo_app/View/components/style.dart';
import 'View/pages/main_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(
      //     fontFamily: GoogleFonts.comfortaa(
      //   color: Colors.black,
      //   fontSize: 30,
      //   fontWeight: FontWeight.w300,
      // )),
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

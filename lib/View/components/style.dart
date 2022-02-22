import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//TEXT

// final TextTheme textTheme = TextTheme(
//   headline1: GoogleFonts.comfortaa(
//       fontSize: 30, fontWeight: FontWeight.w300, letterSpacing: -1.5),
// );

//APP BAR

Color addButton = const Color.fromARGB(0, 0, 114, 255);

ButtonStyle addButtonShape = ButtonStyle(
  shape:
      MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20.0),
  )),
);

// const appbarText = TextStyle(color: Colors.black);

final appbarText = GoogleFonts.comfortaa(
  color: Colors.black,
  fontSize: 30,
  fontWeight: FontWeight.bold,
);

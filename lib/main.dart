import 'package:flutter/material.dart';

import 'home_page.dart';

const Color background = Color(0xFF121212);
const Color purple = Color(0xFFAD00FF);
const Color blue = Color(0xFF11A4E6);
const Color green = Color(0xFF62C744);
const Color red = Color(0xFFf03B3B);
const Color cyan = Color(0xFF009C82);
const Color white = Color(0xFFFFFFFF);
const Color black = Color(0xFF000000);

const fontScale = 1.5;
const TextStyle midnightKernboyTitles = TextStyle(
  fontFamily: "Midnight Kernboy",
  color: cyan,
  fontSize: 24 * fontScale,
);
const TextStyle midnightKernboyHeaders = TextStyle(
  fontFamily: "Midnight Kernboy",
  color: white,
  fontSize: 18 * fontScale,
);
const TextStyle auto1ImportantBody = TextStyle(
  fontFamily: "Auto 1",
  fontStyle: FontStyle.italic,
  color: white,
  fontSize: 12 * fontScale,
);
const TextStyle auto1NormalBody = TextStyle(
  fontFamily: "Auto 1",
  color: white,
  fontSize: 11 * fontScale,
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CMGTwitch",
      theme: ThemeData.dark().copyWith(
        colorScheme: const ColorScheme.dark().copyWith(
          primary: purple, //TextField Outline
          secondary: purple, //FAB
          surface: background, //AppBar
        ),
        scaffoldBackgroundColor: background, //Main Background
      ),
      home: const MyHomePage(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'home_page.dart';
import 'lecture_db.dart';
import 'models/lecture.dart';

const Color background = Color(0xFF121212);
const Color purple = Color(0xFFAD00FF);
const Color blue = Color(0xFF11A4E6);
const Color green = Color(0xFF62C744);
const Color red = Color(0xFFF03B3B);
const Color cyan = Color(0xFF009C82);
const Color white = Color(0xFFFFFFFF);
const Color black = Color(0xFF000000);

const fontScale = 1.5;
const TextStyle midnightKernboyTitles = TextStyle(
  fontFamily: "Midnight Kernboy",
  color: cyan,
  fontSize: 24 * fontScale,
  height: 1,
);
const TextStyle midnightKernboyHeaders = TextStyle(
  fontFamily: "Midnight Kernboy",
  color: white,
  fontSize: 18 * fontScale,
  height: 1,
);
const TextStyle auto1ImportantBody = TextStyle(
  fontFamily: "Auto 1",
  fontStyle: FontStyle.italic,
  color: white,
  fontSize: 12 * fontScale,
  height: 1,
);
const TextStyle auto1NormalBody = TextStyle(
  fontFamily: "Auto 1",
  color: white,
  fontSize: 11 * fontScale,
  height: 1,
);

SvgPicture logoCMGTwitch() => SvgPicture.asset(
      "assets/icons/CMGTwitch.svg",
      semanticsLabel: "CMGTwitch",
      height: 56 / 1.5,
      placeholderBuilder: (_) => Image.asset("assets/icons/CMGTwitch.png"),
    );

void main() {
  //Always have a live lecture
  final DateTime now = DateTime.now();
  final DateTime startTime = DateTime(now.year, now.month, now.day, now.hour);
  final DateTime endTime = startTime.add(const Duration(hours: 2));

  courses.first.lectures.add(
    Lecture("Task: Go to Week 5 in the schedule", startTime, endTime),
  );

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

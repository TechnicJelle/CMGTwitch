import "dart:typed_data";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_svg/svg.dart";
import "package:image_picker_web/image_picker_web.dart";
import "package:flutter_web_plugins/url_strategy.dart";

import "home_page.dart";
import "lecture_db.dart";
import "models/chat_message.dart";
import "models/lecture.dart";

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

AppBar appBar(StateSetter setState, {Widget? leading}) => AppBar(
      title: SvgPicture.asset(
        "assets/icons/CMGTwitch.svg",
        semanticsLabel: "CMGTwitch",
        height: 56 / 1.5,
        placeholderBuilder: (_) => Image.asset("assets/icons/CMGTwitch.png"),
      ),
      elevation: 8,
      leading: leading,
      actions: [
        MouseRegion(
          onEnter: (_) => setState(() {}), //to refresh the icon if it's changed
          child: IconButton(
            icon: you.avatar,
            iconSize: 54,
            onPressed: () async {
              Uint8List? fromPicker = await ImagePickerWeb.getImageAsBytes();
              if (fromPicker != null) {
                setState(() => you.imgProv = MemoryImage(fromPicker));
              }
            },
          ),
        ),
      ],
    );

String version = "";

bool get isLimited => version.contains("A") || version.contains("B");

void main() {
  //Always have a live lecture
  final DateTime now = DateTime.now();
  final DateTime startTime = DateTime(now.year, now.month, now.day, now.hour);
  final DateTime endTime = startTime.add(const Duration(hours: 2));

  courses.first.lectures.add(
    Lecture(
      "Lecture 4: Demonstration: How to make a Twitch/YouTube clone in Flutter",
      startTime,
      endTime,
      [john],
      chat: [
        ChatMessage("This message was totally sent earlier", you, startTime),
        ChatMessage("..and so was this one", you, startTime),
        ChatMessage("Welcome to the lecture!", john, startTime),
      ],
    ),
  );

  usePathUrlStrategy();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CMGTwitch",
      onGenerateRoute: (settings) {
        version = settings.name ?? "";
        return null;
      },
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

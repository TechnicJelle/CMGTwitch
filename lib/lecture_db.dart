import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'main.dart';
import 'pages/video.dart';

enum Audience {
  engineer(blue),
  artist(red),
  designer(green);

  const Audience(this.colour);

  final Color colour;
}

class Course {
  String name;
  List<Audience> audience;
  List<Lecture> lectures;

  Course(this.name, this.audience, this.lectures);

  Color get colour => audience.length == 1 ? audience.first.colour : cyan;
}

DateFormat _timeFormHHmm = DateFormat("HH:mm");
DateFormat _timeFormHHmmss = DateFormat("HH:mm:ss");

class Lecture {
  String name;
  DateTime startTime;
  DateTime endTime;
  List<ChatMessage> chat = [];

  Lecture(this.name, this.startTime, this.endTime, [chat]) {
    if (chat != null) {
      this.chat = chat;
    }
  }

  bool get isLive =>
      DateTime.now().isAfter(startTime) && DateTime.now().isBefore(endTime);

  String get time =>
      "${_timeFormHHmm.format(startTime)} - ${_timeFormHHmm.format(endTime)}";

  String get duration {
    Duration diff = endTime.difference(startTime);
    return formatDuration(diff);
  }

  void watch(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
        opacity: animation,
        child: VideoPage(this),
      ),
      transitionDuration: const Duration(milliseconds: 100),
    ));
  }
}

class ChatMessage {
  String text;
  String sender;
  DateTime time;

  String get timeStr => _timeFormHHmmss.format(time);

  ChatMessage(this.text, this.sender, this.time);
}

List<ChatMessage> mockChat = [
  ChatMessage(
    "Hello!",
    "John",
    DateTime(2023, DateTime.january, 30, 9, 00, 00),
  ),
  ChatMessage(
    "Hi!",
    "Claudia",
    DateTime(2023, DateTime.january, 30, 9, 00, 10),
  ),
  ChatMessage(
    "How are you?",
    "John",
    DateTime(2023, DateTime.january, 30, 9, 00, 20),
  ),
  ChatMessage(
    "I'm fine, thanks!",
    "Claudia",
    DateTime(2023, DateTime.january, 30, 9, 00, 30),
  ),
  ChatMessage(
    "What are you doing?",
    "John",
    DateTime(2023, DateTime.january, 30, 9, 00, 40),
  ),
  ChatMessage(
    "I'm watching a lecture!",
    "Claudia",
    DateTime(2023, DateTime.january, 30, 9, 00, 50),
  ),
  ChatMessage(
    "Cool!",
    "John",
    DateTime(2023, DateTime.january, 30, 9, 00, 55),
  ),
  ChatMessage(
    "This is a super long message to test if the text wraps nicely and properly when the chat text messages become too long to just fit on the screen",
    "Long John",
    DateTime(2023, DateTime.january, 30, 9, 01, 00),
  ),
  ChatMessage(
    "And sure enough...\nIt does!",
    "Long John",
    DateTime(2023, DateTime.january, 30, 9, 01, 05),
  ),
];

List<Course> courses = [
  Course(
    "UI/UX Advanced",
    [Audience.engineer, Audience.artist, Audience.designer],
    [
      Lecture(
        "Lecture 1: Buttons and Navigation",
        DateTime(2023, DateTime.january, 30, 9, 00),
        DateTime(2023, DateTime.january, 30, 11, 00),
        mockChat,
      ),
      Lecture(
        "Lecture 2: How to make your UI look good",
        DateTime(2023, DateTime.february, 2, 11, 00),
        DateTime(2023, DateTime.february, 2, 13, 00),
      ),
      Lecture(
        "Lecture 3: How to make your UI not look like a 90s website",
        DateTime(2023, DateTime.february, 6, 8, 30),
        DateTime(2023, DateTime.february, 6, 10, 30),
      ),
    ],
  ),
  Course(
    "3D Rendering",
    [Audience.engineer],
    [
      Lecture(
        "Lec01: OpenGL and Shaders",
        DateTime(2023, DateTime.january, 31, 9, 00),
        DateTime(2023, DateTime.january, 31, 11, 00),
      ),
      Lecture(
        "Lec02: Lighting and Shadows",
        DateTime(2023, DateTime.february, 6, 10, 30),
        DateTime(2023, DateTime.february, 6, 12, 30),
      ),
    ],
  ),
  Course(
    "Game Design",
    [Audience.designer],
    [
      Lecture(
        "Lecture 1: Where to put coins in your levels",
        DateTime(2023, DateTime.january, 31, 10, 00),
        DateTime(2023, DateTime.january, 31, 12, 00),
      ),
      Lecture(
        "Lecture 2: How to design good levels and UI without looking like an absolute doofus",
        DateTime(2023, DateTime.february, 2, 10, 00),
        DateTime(2023, DateTime.february, 2, 12, 00),
      ),
      Lecture(
        "Lecture 3: How to make your game look good with VFX",
        DateTime(2023, DateTime.february, 6, 11, 00),
        DateTime(2023, DateTime.february, 6, 12, 30),
      ),
    ],
  ),
  Course(
    "3D Modeling",
    [Audience.artist],
    [
      Lecture(
        "Lec1: Blender basics",
        DateTime(2023, DateTime.february, 1, 9, 00),
        DateTime(2023, DateTime.february, 1, 11, 00),
      ),
      Lecture(
        "Lec2: Blender advanced",
        DateTime(2023, DateTime.february, 2, 9, 00),
        DateTime(2023, DateTime.february, 2, 11, 00),
      ),
      Lecture(
        "Lec3: Blender compositing",
        DateTime(2023, DateTime.february, 6, 16, 00),
        DateTime(2023, DateTime.february, 6, 18, 00),
      ),
    ],
  ),
];

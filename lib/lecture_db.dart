import 'dart:ui';

import 'package:intl/intl.dart';

import 'main.dart';

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

DateFormat _formatter = DateFormat("HH:mm");

class Lecture {
  String name;
  DateTime startTime;
  DateTime endTime;

  Lecture(this.name, this.startTime, this.endTime);

  bool get isLive =>
      DateTime.now().isAfter(startTime) && DateTime.now().isBefore(endTime);

  String get time =>
      "${_formatter.format(startTime)} - ${_formatter.format(endTime)}";

  String get duration {
    Duration diff = endTime.difference(startTime);
    return formatDuration(diff);
  }

  void watch() {
    print("Watch lecture: $name");
  }
}

String formatDuration(Duration d) {
  int hours = d.inHours;
  bool hasHours = hours > 0;

  int minutes = d.inMinutes % 60;
  String minutesString = minutes.toString();
  if (hasHours) {
    minutesString = minutesString.padLeft(2, "0");
  }

  String seconds = (d.inSeconds % 60).toString().padLeft(2, "0");

  if (hasHours) {
    return "$hours:$minutesString:$seconds";
  } else {
    return "$minutes:$seconds";
  }
}

List<Course> courses = [
  Course(
    "UI/UX Advanced",
    [Audience.engineer, Audience.artist, Audience.designer],
    [
      Lecture(
        "Lecture 1: Buttons and Navigation",
        DateTime(2023, DateTime.january, 30, 9, 00),
        DateTime(2023, DateTime.january, 30, 11, 00),
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

import "package:flutter/material.dart";
import "package:intl/intl.dart";

import "../pages/video.dart";
import "../models/chat_message.dart";
import "person.dart";

DateFormat _timeFormHHmm = DateFormat("HH:mm");

class Lecture {
  String title;
  DateTime startTime;
  DateTime endTime;
  List<Person> speakers = [];
  List<String> tags = [];
  List<ChatMessage> chat = [];

  Lecture(this.title, this.startTime, this.endTime, this.speakers, {tags, chat})
      : assert(startTime.isBefore(endTime)),
        assert(startTime != endTime),
        tags = tags ?? [],
        chat = chat ?? [];

  bool get isLive =>
      DateTime.now().isAfter(startTime) && DateTime.now().isBefore(endTime);

  String get time =>
      "${_timeFormHHmm.format(startTime)} - ${_timeFormHHmm.format(endTime)}";

  double get durationHours {
    double minutes = endTime.difference(startTime).inMinutes.toDouble();
    return minutes / 60;
  }

  String get durationString => formatDuration(endTime.difference(startTime));

  String get thumbnail => "https://picsum.photos/seed/$hashCode/800/450";

  void watch(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
        opacity: animation,
        child: VideoPage(this),
      ),
    ));
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

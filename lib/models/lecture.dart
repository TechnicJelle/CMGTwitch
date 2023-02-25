import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../pages/video.dart';
import 'chat_message.dart';

DateFormat _timeFormHHmm = DateFormat("HH:mm");

class Lecture {
  String title;
  DateTime startTime;
  DateTime endTime;
  List<String> tags = [];
  List<ChatMessage> chat = [];

  Lecture(this.title, this.startTime, this.endTime, {tags, chat})
      : assert(startTime.isBefore(endTime)),
        assert(startTime != endTime),
        tags = tags ?? [],
        chat = chat ?? [];

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

import 'package:flutter/material.dart';

import '../lecture_db.dart';
import '../main.dart';

class VideoPage extends StatefulWidget {
  const VideoPage(this.lecture, {super.key});

  final Lecture lecture;

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  Lecture get lecture => widget.lecture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: logoCMGTwitch(),
      ),
      body: DefaultTextStyle(
        style: auto1NormalBody,
        child: Center(
          child: Wrap(
            direction: Axis.vertical,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 4,
            children: [
              const Text("Lecture page", style: midnightKernboyTitles),
              const Text("This is where the video will be"),
              const Text("Lecture info", style: midnightKernboyHeaders),
              Text(lecture.name),
              Text("Start: ${lecture.startTime}"),
              Text("End: ${lecture.endTime}"),
              Text("Is live: ${lecture.isLive}"),
              Text("Time: ${lecture.time}"),
              Text("Duration: ${lecture.duration}"),
            ],
          ),
        ),
      ),
    );
  }
}

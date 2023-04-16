import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:scrollable_positioned_list/scrollable_positioned_list.dart";

import "../lecture_db.dart";
import "../main.dart";
import "../models/lecture.dart";

class ScheduleB extends StatefulWidget {
  final List<Lecture> lectures;

  ScheduleB({super.key})
      : lectures =
            courses.map((course) => course.lectures).expand((i) => i).toList() {
    lectures.sort((a, b) => a.startTime.compareTo(b.startTime));
  }

  @override
  State<ScheduleB> createState() => _ScheduleBState();
}

class _ScheduleBState extends State<ScheduleB> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  List<Lecture> get lectures => widget.lectures;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ScrollablePositionedList.builder(
          itemCount: lectures.length,
          itemScrollController: itemScrollController,
          itemPositionsListener: itemPositionsListener,
          itemBuilder: (context, index) {
            final Lecture? prevLecture = index > 0 ? lectures[index - 1] : null;
            final Lecture lecture = lectures[index];
            final bool isFirstLectureOfTheDay = prevLecture == null ||
                prevLecture.startTime.day != lecture.startTime.day;
            return Column(
              children: [
                if (isFirstLectureOfTheDay)
                  Padding(
                    padding: const EdgeInsets.only(top: 24, bottom: 8),
                    child: _DayHeader(lecture.startTime),
                  ),
                _LectureEntry(lecture),
              ],
            );
          },
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24, right: 24),
            child: FloatingActionButton(
              tooltip: "Scroll to today's lectures",
              onPressed: () {
                itemScrollController.scrollTo(
                  index: lectures.indexOf(
                      lectures.firstWhere((lecture) => lecture.isLive)),
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut,
                );
              },
              child: const Icon(Icons.file_download_outlined),
            ),
          ),
        )
      ],
    );
  }
}

class _LectureEntry extends StatelessWidget {
  final Lecture lecture;

  const _LectureEntry(this.lecture);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => lecture.watch(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            const SizedBox(width: 16),
            CircleAvatar(backgroundColor: lecture.course.colour, radius: 6),
            const SizedBox(width: 8),
            Text(lecture.course.name, style: auto1ImportantBody),
            const SizedBox(width: 16),
            if (lecture.isLive) const Icon(Icons.play_circle, color: red),
            if (lecture.isLive) const SizedBox(width: 8),
            Column(
              children: [
                Text(
                  DateFormat("HH:mm").format(lecture.startTime),
                  style: auto1ImportantBody,
                ),
                const SizedBox(width: 4),
                Text(
                  DateFormat("HH:mm").format(lecture.endTime),
                  style: auto1NormalBody.copyWith(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(lecture.title, style: auto1ImportantBody),
                  const SizedBox(height: 4),
                  Text(
                    lecture.speakers.join(", "),
                    style: auto1NormalBody.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DayHeader extends StatelessWidget {
  final DateTime day;

  const _DayHeader(this.day);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(DateFormat("EEEE").format(day), style: midnightKernboyTitles),
        Text(DateFormat("d MMMM").format(day), style: auto1ImportantBody),
      ],
    );
  }
}

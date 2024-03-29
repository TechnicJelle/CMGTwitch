import "package:flutter/material.dart";
import "package:syncfusion_flutter_calendar/calendar.dart";

import "../lecture_db.dart";
import "../main.dart";
import "../models/course.dart";
import "../models/lecture.dart";

class ScheduleA extends StatefulWidget {
  const ScheduleA({super.key});

  @override
  State<ScheduleA> createState() => _ScheduleAState();
}

class _ScheduleAState extends State<ScheduleA> {
  final TextStyle monthNonDays = auto1NormalBody.copyWith(
    color: auto1NormalBody.color?.withOpacity(0.4),
  );

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      dataSource: _MeetingDataSource(_getDataSource()),
      view: CalendarView.workWeek,
      allowedViews: const [
        CalendarView.day,
        CalendarView.workWeek,
        CalendarView.month,
        // CalendarView.schedule,
      ],
      showNavigationArrow: true,
      // Header (January 2023)
      headerDateFormat: "MMMM yyyy",
      headerStyle: const CalendarHeaderStyle(
        textStyle: midnightKernboyTitles,
      ),
      showDatePickerButton: true,
      // View Header (Days+Dates)
      viewHeaderStyle: ViewHeaderStyle(
        dayTextStyle: midnightKernboyHeaders.copyWith(height: 0.7),
        dateTextStyle: auto1ImportantBody,
      ),
      // Settings for specific views
      // Day View
      timeSlotViewSettings: const TimeSlotViewSettings(
        startHour: 8,
        endHour: 22,
        timeIntervalHeight: 60,
        timeFormat: "HH:mm",
        dayFormat: "EEE",
        dateFormat: "dd",
        timeTextStyle: auto1NormalBody,
      ),
      // WorkWeek View
      firstDayOfWeek: DateTime.monday,
      showWeekNumber: true,
      weekNumberStyle: const WeekNumberStyle(
        textStyle: auto1NormalBody,
      ),
      // Month View
      monthViewSettings: MonthViewSettings(
        // Adds a secondary view underneath with info about the day:
        showAgenda: true,
        dayFormat: "EEEE",
        showTrailingAndLeadingDates: true,
        navigationDirection: MonthNavigationDirection.horizontal,
        monthCellStyle: MonthCellStyle(
          textStyle: auto1NormalBody,
          leadingDatesTextStyle: monthNonDays,
          trailingDatesTextStyle: monthNonDays,
        ),
        appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
        appointmentDisplayCount: 9,
        agendaItemHeight: 70,
        agendaStyle: const AgendaStyle(
          appointmentTextStyle: auto1NormalBody,
          dateTextStyle: auto1ImportantBody,
          dayTextStyle: midnightKernboyHeaders,
        ),
      ),
      appointmentBuilder: (context, CalendarAppointmentDetails details) {
        final _Meeting meeting = details.appointments.first;
        final Lecture lecture = meeting.lecture;

        return Container(
          decoration: BoxDecoration(
            color: meeting.background,
            borderRadius: BorderRadius.circular(4),
          ),
          child: GestureDetector(
            onDoubleTap: () => lecture.watch(context),
            child: Stack(
              children: [
                ListTile(
                  title: Text(
                    meeting.eventName,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style:
                        auto1ImportantBody.copyWith(color: white, height: 1.1),
                  ),
                  subtitle: Text(
                    lecture.time + (lecture.isLive ? " (Live!)" : ""),
                    style: auto1NormalBody.copyWith(color: Colors.white70),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(
                      onPressed: () => lecture.watch(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white70),
                      ),
                      child: Text(
                        "Watch",
                        style: auto1NormalBody.copyWith(color: Colors.white70),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<_Meeting> _getDataSource() {
    final List<_Meeting> meetings = [];
    for (Course course in courses) {
      for (Lecture lecture in course.lectures) {
        meetings.add(
          _Meeting("${course.name}\n${lecture.title}", lecture, course.colour),
        );
      }
    }

    //Point user to some actual planned lectures
    final DateTime now = DateTime.now();
    final DateTime startTime = DateTime(now.year, now.month, now.day, 10);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(
      _Meeting(
        "Task 1 hint: It's around the beginning of February",
        Lecture("Not this lecture ;)", startTime, endTime, [you]),
        cyan,
      ),
    );

    return meetings;
  }
}

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class _MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  _MeetingDataSource(List<_Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).lecture.startTime;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).lecture.endTime;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).lecture.title;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  _Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final _Meeting meetingData;
    if (meeting is _Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

class _Meeting {
  _Meeting(this.eventName, this.lecture, this.background);

  String eventName;
  Lecture lecture;
  Color background;
}

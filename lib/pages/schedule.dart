import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../main.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  final TextStyle monthNonDays = auto1NormalBody.copyWith(
    color: auto1NormalBody.color?.withOpacity(0.4),
  );

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      dataSource: MeetingDataSource(_getDataSource()),
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
      headerStyle: CalendarHeaderStyle(
        textStyle: midnightKernboyTitles.copyWith(height: 1.0),
      ),
      showDatePickerButton: true,
      // View Header (Days+Dates)
      viewHeaderStyle: ViewHeaderStyle(
        dayTextStyle: midnightKernboyHeaders.copyWith(height: 0.7),
        dateTextStyle: auto1ImportantBody.copyWith(height: 1.0),
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
      ),
    );
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(
        Meeting("UI/UX Advanced Lecture", startTime, endTime, blue, false));
    return meetings;
  }
}

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}

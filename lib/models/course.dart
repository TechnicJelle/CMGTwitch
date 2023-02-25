import 'dart:ui';

import '../main.dart';
import 'audience.dart';
import 'lecture.dart';

class Course {
  String name;
  List<Audience> audience;
  List<Lecture> lectures;

  Course(this.name, this.audience, this.lectures);

  Color get colour => audience.length == 1 ? audience.first.colour : cyan;
}

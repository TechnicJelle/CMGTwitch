import 'dart:collection';

import 'package:cmgtwitch/models/audience.dart';
import 'package:cmgtwitch/models/course.dart';
import 'package:flutter/material.dart';

import '../lecture_db.dart';
import '../main.dart';
import '../models/lecture.dart';

class FilterSidebar extends StatefulWidget {
  final _FilterStatus _status = _FilterStatus();

  FilterSidebar({super.key});

  bool get filterActive => _status.filterActive;

  List<Lecture> filterLectures() {
    HashSet<Lecture> filteredLectures = HashSet();
    for (Course course in courses) {
      for (Lecture lecture in course.lectures) {
        if (_status.engineers.value &&
            course.audience.contains(Audience.engineer)) {
          filteredLectures.add(lecture);
        }
        if (_status.designers.value &&
            course.audience.contains(Audience.designer)) {
          filteredLectures.add(lecture);
        }
        if (_status.artists.value &&
            course.audience.contains(Audience.artist)) {
          filteredLectures.add(lecture);
        }
      }
    }
    return filteredLectures.toList();
  }

  @override
  State<FilterSidebar> createState() => _FilterSidebarState();
}

class _FilterStatus {
  _BoolWithDefault engineers = _BoolWithDefault(true);
  _BoolWithDefault designers = _BoolWithDefault(true);
  _BoolWithDefault artists = _BoolWithDefault(true);

  bool get filterActive =>
      !engineers.isDefault || !designers.isDefault || !artists.isDefault;

  void reset() {
    engineers.reset();
    designers.reset();
    artists.reset();
  }
}

class _BoolWithDefault {
  bool value;
  final bool _defaultValue;

  _BoolWithDefault(this._defaultValue) : value = _defaultValue;

  bool get isDefault => value == _defaultValue;

  void reset() => value = _defaultValue;
}

class _FilterSidebarState extends State<FilterSidebar> {
  _FilterStatus get status => widget._status;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      width: 300,
      child: ListView(
        children: [
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text("Filter", style: midnightKernboyTitles),
              ),
              TextButton(
                onPressed: status.filterActive
                    ? () => setState(() => status.reset())
                    : null,
                child: Text(
                  "Clear Filters",
                  style: auto1ImportantBody.copyWith(
                      color: status.filterActive ? purple : Colors.grey),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          ListTile(
            title: const Text(
              "Target Audience",
              style: midnightKernboyHeaders,
            ),
            subtitle: Column(
              children: [
                CheckboxListTile(
                  title: const Text("Engineers", style: auto1NormalBody),
                  dense: true,
                  value: status.engineers.value,
                  onChanged: (bool? val) => setState(() {
                    status.engineers.value = val!;
                  }),
                ),
                CheckboxListTile(
                  title: const Text("Designers", style: auto1NormalBody),
                  dense: true,
                  value: status.designers.value,
                  onChanged: (bool? val) => setState(() {
                    status.designers.value = val!;
                  }),
                ),
                CheckboxListTile(
                  title: const Text("Artists", style: auto1NormalBody),
                  dense: true,
                  value: status.artists.value,
                  onChanged: (bool? val) => setState(() {
                    status.artists.value = val!;
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

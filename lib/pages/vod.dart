import "dart:collection";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../main.dart";
import "../lecture_db.dart";
import "../models/audience.dart";
import "../models/course.dart";
import "../models/lecture.dart";
import "../widgets/filter_sidebar.dart";
import "../widgets/lecture_card.dart";

final _filterPanelExpandedProvider = StateProvider<bool>((ref) => false);

class VOD extends ConsumerWidget {
  const VOD({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FilterStatus filterStatus = ref.watch(filterStatusProvider);
    final bool filterPanelExpanded = ref.watch(_filterPanelExpandedProvider);

    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              _TopBar(filterStatus),
              Flexible(
                child: _Content(filterStatus),
              ),
            ],
          ),
        ),
        if (filterPanelExpanded) const FilterSidebar(),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final FilterStatus filterStatus;

  const _Content(this.filterStatus);

  static List<Lecture> _filterLectures(FilterStatus status) {
    HashSet<Lecture> filteredLectures = HashSet();
    for (Course course in courses) {
      for (Lecture lecture in course.lectures) {
        if (status.engineers && course.audience.contains(Audience.engineer)) {
          filteredLectures.add(lecture);
        }
        if (status.designers && course.audience.contains(Audience.designer)) {
          filteredLectures.add(lecture);
        }
        if (status.artists && course.audience.contains(Audience.artist)) {
          filteredLectures.add(lecture);
        }
      }
    }
    return filteredLectures.toList();
  }

  @override
  Widget build(BuildContext context) {
    if (filterStatus.filterActive) {
      List<Lecture> filteredLectures = _filterLectures(filterStatus);
      if (filteredLectures.isEmpty) {
        return const Center(
          child: Text("No lectures found", style: auto1NormalBody),
        );
      } else {
        return ListView(children: [
          _Course("Filter results", cyan, filteredLectures),
        ]);
      }
    } else {
      List<Lecture> liveLectures = courses
          .expand((course) => course.lectures)
          .where((lecture) => lecture.isLive)
          .toList();

      return ListView.builder(
        itemCount: courses.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            if (liveLectures.isEmpty) return Container();
            return _Course(
                "> Live now!", const Color(0xFFFF0000), liveLectures);
          } else {
            Course c = courses[index - 1];
            return _Course(c.name, c.colour, c.lectures);
          }
        },
      );
    }
  }
}

class _Course extends StatelessWidget {
  final String name;
  final Color colour;
  final List<Lecture> lectures;

  const _Course(this.name, this.colour, this.lectures);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            name,
            style: midnightKernboyTitles.copyWith(
              color: colour,
            ),
          ),
        ),
        Wrap(
          direction: Axis.horizontal,
          children: [
            for (int i = 0; i < lectures.length; i++)
              SizedBox(
                width: 500,
                child: LectureCard(lectures[i]),
              ),
          ],
        ),
      ],
    );
  }
}

class _TopBar extends ConsumerStatefulWidget {
  final FilterStatus filterStatus;

  const _TopBar(this.filterStatus);

  @override
  ConsumerState<_TopBar> createState() => _TopBarState();
}

class _TopBarState extends ConsumerState<_TopBar> {
  FilterStatus get filterStatus => widget.filterStatus;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            child: Material(
              borderRadius: BorderRadius.circular(8),
              child: TextField(
                style: auto1NormalBody,
                controller: _searchController,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  hintText: "Search",
                  hintStyle:
                      auto1NormalBody.copyWith(color: const Color(0xFFC9C9C9)),
                  prefixIcon: const Icon(Icons.search),
                  contentPadding: const EdgeInsets.all(0),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            _searchController.clear();
                            searchItems("");
                            FocusScope.of(context).unfocus();
                          },
                        )
                      : null,
                ),
                onChanged: (String s) => setState(() => searchItems(s)),
              ),
            ),
          ),
          const SizedBox(width: 3),
          SizedBox(
            width: 48,
            height: 48,
            child: Tooltip(
              message: "Filter (${filterStatus.filterActive ? "On" : "Off"})",
              child: RawMaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                fillColor: Theme.of(context).cardColor,
                child: filterStatus.filterActive
                    ? const Icon(Icons.filter_alt)
                    : const Icon(Icons.filter_alt_off),
                onPressed: () {
                  ref.read(_filterPanelExpandedProvider.notifier).state =
                      !ref.read(_filterPanelExpandedProvider);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void searchItems(String s) {}
}

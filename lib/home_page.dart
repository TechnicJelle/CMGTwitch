import "package:flutter/material.dart";

import "main.dart";
import "pages/schedule_a.dart";
import "pages/schedule_b.dart";
import "pages/vod.dart";

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool get _isLimited => version.contains("A") || version.contains("B");

  bool _extended = false;
  int _selectedIndex = 2; // starting page

  final List<NavigationRailDestination> _destinations = [
    const NavigationRailDestination(
      icon: Icon(Icons.calendar_month),
      label: Text("Scheduled Lectures A"),
    ),
    const NavigationRailDestination(
      icon: Icon(Icons.list_alt),
      label: Text("Scheduled Lectures B"),
    ),
    const NavigationRailDestination(
      icon: Icon(Icons.ondemand_video),
      label: Text("VOD Lectures"),
    ),
  ];

  Widget get _currentPage {
    if (_isLimited) {
      //0 is A or B
      //1 is VOD
      switch (_selectedIndex) {
        case 0:
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: version.contains("A") ? const ScheduleA() : ScheduleB(),
          );
        case 1:
          return const VOD();
        default:
          return const Placeholder();
      }
    }

    switch (_selectedIndex) {
      case 0:
        return const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: ScheduleA(),
        );
      case 1:
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ScheduleB(),
        );
      case 2:
        return const VOD();
      default:
        return const Placeholder();
    }
  }

  @override
  void initState() {
    super.initState();

    if (_isLimited) {
      _destinations.removeAt(1);
      _selectedIndex--;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        setState,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => setState(() => _extended = !_extended),
        ),
      ),
      body: Row(
        children: [
          // Handle thin screens
          if (MediaQuery.of(context).size.width > 500 || _extended)
            NavigationRail(
              extended: _extended,
              elevation: 4,
              destinations: _destinations,
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) =>
                  setState(() => _selectedIndex = index),
              selectedLabelTextStyle: auto1NormalBody.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelTextStyle: auto1NormalBody.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                fontWeight: FontWeight.normal,
              ),
            ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: _currentPage),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'main.dart';
import 'pages/schedule.dart';
import 'pages/vod.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _extended = true;
  int _selectedIndex = 0; // starting page

  final List<NavigationRailDestination> _destinations = const [
    NavigationRailDestination(
      icon: Icon(Icons.calendar_month),
      label: Text("Scheduled Lectures"),
    ),
    NavigationRailDestination(
      icon: Icon(Icons.ondemand_video),
      label: Text("VOD Lectures"),
    ),
  ];

  Widget get _currentPage {
    switch (_selectedIndex) {
      case 0:
        return const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Schedule(),
        );
      case 1:
        return const VOD();
      default:
        return const Placeholder();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          "assets/icons/CMGTwitch.svg",
          semanticsLabel: "CMGTwitch",
          height: 56 / 1.5,
          placeholderBuilder: (_) => Image.asset("assets/icons/CMGTwitch.png"),
        ),
        elevation: 8,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => setState(() => _extended = !_extended),
        ),
      ),
      body: Row(
        children: [
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

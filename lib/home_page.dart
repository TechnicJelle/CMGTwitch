import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

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
      ),
      body: DefaultTextStyle(
        style: auto1NormalBody,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "You have pushed the button this many times:",
                style: auto1ImportantBody,
              ),
              Text('$_counter', style: midnightKernboyHeaders),
              /*---*/ const Divider() /*---*/,
              const Text(
                "Titles: Midnight Kernboy, 24, Bold, 009C82",
                style: midnightKernboyTitles,
              ),
              const Text(
                "Headers: Midnight Kernboy, 18-14, Bold",
                style: midnightKernboyHeaders,
              ),
              const Text(
                "Important body text: Auto 1, 12, Italic",
                style: auto1ImportantBody,
              ),
              const Text(
                "Normal body text: Auto 1, 11, Normal",
                style: auto1NormalBody,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _counter++),
        tooltip: "Increment",
        child: const Icon(Icons.add),
      ),
    );
  }
}

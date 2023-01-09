import 'package:flutter/material.dart';

class VOD extends StatefulWidget {
  const VOD({super.key});

  @override
  State<VOD> createState() => _VODState();
}

class _VODState extends State<VOD> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Text("VOD Page"),
        ],
      ),
    );
  }
}

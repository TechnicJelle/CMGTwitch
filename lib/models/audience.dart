import "package:flutter/material.dart";

import "../main.dart";

enum Audience {
  engineer(blue),
  artist(red),
  designer(green);

  const Audience(this.colour);

  final Color colour;

  Widget get icon => SizedBox.square(
        dimension: 24,
        child: CircleAvatar(
          backgroundColor: colour,
          child: Text(
            name[0].toUpperCase(),
            style: midnightKernboyHeaders,
            textScaleFactor: 0.89,
          ),
        ),
      );
}

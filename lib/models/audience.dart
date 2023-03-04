import "dart:ui";

import "../main.dart";

enum Audience {
  engineer(blue),
  artist(red),
  designer(green);

  const Audience(this.colour);

  final Color colour;
}

import 'package:flutter/material.dart';

import '../main.dart';

class Person {
  String name;
  String? avatarUrl;
  ImageProvider? imgProv;

  Person(this.name, [this.avatarUrl]);

  CircleAvatar get avatar => avatarUrl == null && imgProv == null
      ? CircleAvatar(
          backgroundColor: Colors.blue,
          child: Text(name[0], style: midnightKernboyHeaders),
        )
      : CircleAvatar(backgroundImage: imgProv ?? NetworkImage(avatarUrl!));
}

import 'package:flutter/material.dart';

import '../main.dart';

class Person {
  String name;
  String? avatarUrl;

  Person(this.name, [this.avatarUrl]);

  CircleAvatar get avatar => avatarUrl == null
      ? CircleAvatar(
          backgroundColor: Colors.blue,
          child: Text(name[0], style: midnightKernboyHeaders),
        )
      : CircleAvatar(backgroundImage: NetworkImage(avatarUrl!));
}

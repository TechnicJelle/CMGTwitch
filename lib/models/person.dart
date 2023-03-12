import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";

import "../main.dart";

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
      : CircleAvatar(
          backgroundImage: imgProv ?? CachedNetworkImageProvider(avatarUrl!),
        );

  @override
  String toString() => name;
}

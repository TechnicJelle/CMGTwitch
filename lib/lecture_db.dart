import "models/audience.dart";
import "models/chat_message.dart";
import "models/course.dart";
import "models/lecture.dart";
import "models/person.dart";

Person you = Person("You");

Person john = Person(
  "John Doe",
  "https://upload.wikimedia.org/wikipedia/commons/4/45/Mainecoon-lap.jpg",
); //Source: https://commons.wikimedia.org/wiki/File:Mainecoon-lap.jpg
Person _claudia = Person("Claudia Smith");
Person _longJohn = Person("Long John");

List<ChatMessage> _mockChat = [
  ChatMessage(
    "Hello!",
    john,
    DateTime(2023, DateTime.january, 30, 9, 00, 00),
  ),
  ChatMessage(
    "Hi!",
    _claudia,
    DateTime(2023, DateTime.january, 30, 9, 00, 10),
  ),
  ChatMessage(
    "How are you?",
    john,
    DateTime(2023, DateTime.january, 30, 9, 00, 20),
  ),
  ChatMessage(
    "I'm fine, thanks!",
    _claudia,
    DateTime(2023, DateTime.january, 30, 9, 00, 30),
  ),
  ChatMessage(
    "What are you doing?",
    john,
    DateTime(2023, DateTime.january, 30, 9, 00, 40),
  ),
  ChatMessage(
    "I'm watching a lecture!",
    _claudia,
    DateTime(2023, DateTime.january, 30, 9, 00, 50),
  ),
  ChatMessage(
    "Cool!",
    john,
    DateTime(2023, DateTime.january, 30, 9, 00, 55),
  ),
  ChatMessage(
    "This is a super long message to test if the text wraps nicely and properly when the chat text messages become too long to just fit on the screen",
    _longJohn,
    DateTime(2023, DateTime.january, 30, 9, 01, 00),
  ),
  ChatMessage(
    "And sure enough...\nIt does!",
    _longJohn,
    DateTime(2023, DateTime.january, 30, 9, 01, 05),
  ),
  ChatMessage(
    "And this was a message I sent way back in the past",
    you,
    DateTime(2023, DateTime.january, 30, 9, 39, 04),
  ),
];

List<Course> courses = [
  Course(
    "UI/UX Advanced",
    [Audience.engineer, Audience.artist, Audience.designer],
    [
      Lecture(
        "Lecture 1: Buttons and Navigation",
        DateTime(2023, DateTime.january, 30, 9, 00),
        DateTime(2023, DateTime.january, 30, 11, 00),
        [john],
        tags: ["Buttons", "Navigation", "UI/UX"],
      ),
      Lecture(
        "Lecture 2: How to make your UI look good",
        DateTime(2023, DateTime.february, 2, 11, 00),
        DateTime(2023, DateTime.february, 2, 13, 00),
        [john, _claudia],
      ),
      Lecture(
        "Lecture 3: How to make your UI not look like a 90s website",
        DateTime(2023, DateTime.february, 6, 8, 30),
        DateTime(2023, DateTime.february, 6, 10, 30),
        [john],
      ),
      Lecture(
        "Lecture 4: How to do user testing",
        DateTime(2023, DateTime.february, 13, 8, 30),
        DateTime(2023, DateTime.february, 13, 10, 30),
        [john],
      ),
      Lecture(
        "Lecture 5: How to not even need to ever do user testing",
        DateTime(2023, DateTime.february, 17, 13, 30),
        DateTime(2023, DateTime.february, 17, 16, 30),
        [john],
      ),
      Lecture(
        "Lecture 6: Which prototyping tools exist?",
        DateTime(2023, DateTime.february, 23, 10, 0),
        DateTime(2023, DateTime.february, 23, 11, 0),
        [john],
      ),
      Lecture(
        "Lecture 7: How to choose the best prototyping tool for your project",
        DateTime(2023, DateTime.february, 28, 13, 30),
        DateTime(2023, DateTime.february, 28, 16, 30),
        [john],
      ),
    ],
  ),
  Course(
    "3D Rendering",
    [Audience.engineer],
    [
      Lecture(
        "Lec01: OpenGL and Shaders",
        DateTime(2023, DateTime.january, 31, 9, 00),
        DateTime(2023, DateTime.january, 31, 11, 00),
        [john],
      ),
      Lecture(
        "Lec02: Lighting and Shadows",
        DateTime(2023, DateTime.february, 6, 10, 30),
        DateTime(2023, DateTime.february, 6, 12, 30),
        [john],
      ),
      Lecture(
        "Lec03: PBR and Materials",
        DateTime(2023, DateTime.february, 21, 12, 00),
        DateTime(2023, DateTime.february, 21, 14, 30),
        [john],
      ),
      Lecture(
        "Lec04: Post Processing",
        DateTime(2023, DateTime.february, 28, 10, 00),
        DateTime(2023, DateTime.february, 28, 12, 30),
        [john],
      ),
      Lecture(
        "Lec05: Ray Tracing",
        DateTime(2023, DateTime.march, 7, 13, 30),
        DateTime(2023, DateTime.march, 7, 16, 30),
        [john],
      ),
      Lecture(
        "Lec06: Advanced Rendering Techniques",
        DateTime(2023, DateTime.march, 14, 8, 30),
        DateTime(2023, DateTime.march, 14, 11, 30),
        [john],
      ),
    ],
  ),
  Course(
    "Game Design",
    [Audience.designer],
    [
      Lecture(
        "Lecture 1: Where to put coins in your levels",
        DateTime(2023, DateTime.january, 31, 10, 00),
        DateTime(2023, DateTime.january, 31, 12, 00),
        [john],
      ),
      Lecture(
        "Lecture 2: How to design good levels and UI without looking like an absolute doofus",
        DateTime(2023, DateTime.february, 2, 10, 00),
        DateTime(2023, DateTime.february, 2, 12, 00),
        [john],
      ),
      Lecture(
        "Lecture 3: How to make your game look good with VFX",
        DateTime(2023, DateTime.february, 6, 11, 00),
        DateTime(2023, DateTime.february, 6, 13, 00),
        [john],
      ),
      Lecture(
        "Lecture 4: How to keep your engineers happy",
        DateTime(2023, DateTime.february, 16, 11, 00),
        DateTime(2023, DateTime.february, 16, 13, 00),
        [john],
      ),
      Lecture(
        "Lecture 5: How to keep your artists happy",
        DateTime(2023, DateTime.february, 23, 13, 00),
        DateTime(2023, DateTime.february, 23, 15, 00),
        [john],
      ),
      Lecture(
        "Lecture 6: How to keep yourself happy",
        DateTime(2023, DateTime.february, 24, 11, 00),
        DateTime(2023, DateTime.february, 24, 12, 30),
        [john],
      ),
    ],
  ),
  Course(
    "3D Modeling",
    [Audience.artist],
    [
      Lecture(
        "Lec1: Blender basics",
        DateTime(2023, DateTime.february, 1, 9, 00),
        DateTime(2023, DateTime.february, 1, 11, 00),
        [john],
      ),
      Lecture(
        "Lec2: Blender advanced",
        DateTime(2023, DateTime.february, 2, 9, 00),
        DateTime(2023, DateTime.february, 2, 11, 00),
        [john],
      ),
      Lecture(
        "Lec3: Blender compositing",
        DateTime(2023, DateTime.february, 6, 16, 00),
        DateTime(2023, DateTime.february, 6, 18, 00),
        [john],
      ),
      Lecture(
        "Lec4: Blender sculpting",
        DateTime(2023, DateTime.february, 22, 11, 00),
        DateTime(2023, DateTime.february, 22, 13, 00),
        [john],
      ),
      Lecture(
        "Lec5: Blender animation",
        DateTime(2023, DateTime.february, 8, 14, 00),
        DateTime(2023, DateTime.february, 8, 16, 30),
        chat: _mockChat,
        [john],
      ),
      Lecture(
        "Lec6: Blender rendering",
        DateTime(2023, DateTime.february, 9, 9, 00),
        DateTime(2023, DateTime.february, 9, 12, 00),
        [john],
      ),
    ],
  ),
  Course(
    "Procedural Art",
    [Audience.artist, Audience.designer, Audience.engineer],
    [
      Lecture(
        "Lecture 1: How to make a procedural art generator",
        DateTime(2023, DateTime.march, 1, 9, 00),
        DateTime(2023, DateTime.march, 1, 12, 00),
        [john],
      ),
      Lecture(
        "Lecture 2: How to use perlin noise",
        DateTime(2023, DateTime.march, 8, 9, 00),
        DateTime(2023, DateTime.march, 8, 12, 00),
        [john],
      ),
      Lecture(
        "Lecture 3: How to use cellular noise",
        DateTime(2023, DateTime.march, 15, 9, 00),
        DateTime(2023, DateTime.march, 15, 12, 00),
        [john],
      ),
      Lecture(
        "Lecture 4: How to use voronoi noise",
        DateTime(2023, DateTime.march, 22, 9, 00),
        DateTime(2023, DateTime.march, 22, 12, 00),
        [john],
      ),
      Lecture(
        "Lecture 5: How to use simplex noise",
        DateTime(2023, DateTime.march, 29, 9, 00),
        DateTime(2023, DateTime.march, 29, 12, 00),
        [john],
      ),
      Lecture(
        "Lecture 6: How to use fractal noise",
        DateTime(2023, DateTime.april, 5, 9, 00),
        DateTime(2023, DateTime.april, 5, 12, 00),
        [john],
      ),
    ],
  ),
  Course(
    "Advanced Tools",
    [Audience.engineer],
    [
      Lecture(
        "Lecture 1: How measure performance",
        DateTime(2023, DateTime.march, 2, 9, 00),
        DateTime(2023, DateTime.march, 2, 12, 00),
        [john],
      ),
      Lecture(
        "Lecture 2: How to use profilers",
        DateTime(2023, DateTime.march, 9, 9, 00),
        DateTime(2023, DateTime.march, 9, 12, 00),
        [john],
      ),
      Lecture(
        "Lecture 3: How to use debuggers",
        DateTime(2023, DateTime.march, 16, 9, 00),
        DateTime(2023, DateTime.march, 16, 12, 00),
        [john],
      ),
      Lecture(
        "Lecture 4: How to use memory profilers",
        DateTime(2023, DateTime.march, 23, 9, 00),
        DateTime(2023, DateTime.march, 23, 12, 00),
        [john],
      ),
      Lecture(
        "Lecture 5: How to use code profilers",
        DateTime(2023, DateTime.march, 30, 9, 00),
        DateTime(2023, DateTime.march, 30, 12, 00),
        [john],
      ),
      Lecture(
        "Lecture 6: How to use code coverage",
        DateTime(2023, DateTime.april, 6, 9, 00),
        DateTime(2023, DateTime.april, 6, 12, 00),
        [john],
      ),
    ],
  ),
  Course(
    "Networking",
    [Audience.engineer],
    [
      Lecture(
        "Lecture 1: How to make a networked game",
        DateTime(2023, DateTime.march, 3, 9, 00),
        DateTime(2023, DateTime.march, 3, 12, 00),
        [john],
      ),
      Lecture(
        "Lecture 2: TCP",
        DateTime(2023, DateTime.march, 10, 9, 00),
        DateTime(2023, DateTime.march, 10, 12, 00),
        [john],
      ),
      Lecture(
        "Lecture 3: UDP",
        DateTime(2023, DateTime.march, 17, 9, 00),
        DateTime(2023, DateTime.march, 17, 12, 00),
        [john],
      ),
      Lecture(
        "Lecture 4: WebSockets",
        DateTime(2023, DateTime.march, 24, 9, 00),
        DateTime(2023, DateTime.march, 24, 12, 00),
        [john],
      ),
      Lecture(
        "Lecture 5: Libraries for networking",
        DateTime(2023, DateTime.march, 31, 9, 00),
        DateTime(2023, DateTime.march, 31, 12, 00),
        [john],
      ),
      Lecture(
        "Lecture 6: Unity keeps deprecated their networking libraries",
        DateTime(2023, DateTime.april, 7, 9, 00),
        DateTime(2023, DateTime.april, 7, 12, 00),
        [john],
      ),
    ],
  ),
  Course(
    "Multimodal Interaction",
    [Audience.designer],
    [
      Lecture(
        "Lecture 1: How to make a multimodal game",
        DateTime(2023, DateTime.march, 2, 11, 00),
        DateTime(2023, DateTime.march, 2, 13, 00),
        [john],
      ),
      Lecture(
        "Lecture 2: How to use voice",
        DateTime(2023, DateTime.march, 9, 11, 00),
        DateTime(2023, DateTime.march, 9, 13, 00),
        [john],
      ),
      Lecture(
        "Lecture 3: How to use gestures",
        DateTime(2023, DateTime.march, 16, 11, 00),
        DateTime(2023, DateTime.march, 16, 13, 00),
        [john],
      ),
      Lecture(
        "Lecture 4: How to use eye tracking",
        DateTime(2023, DateTime.march, 23, 11, 00),
        DateTime(2023, DateTime.march, 23, 13, 00),
        [john],
      ),
      Lecture(
        "Lecture 5: How to use haptics",
        DateTime(2023, DateTime.march, 30, 11, 00),
        DateTime(2023, DateTime.march, 30, 13, 00),
        [john],
      ),
      Lecture(
        "Lecture 6: How to use XR",
        DateTime(2023, DateTime.april, 6, 11, 00),
        DateTime(2023, DateTime.april, 6, 13, 00),
        [john],
      ),
    ],
  ),
  Course(
    "Gamification",
    [Audience.designer],
    [
      Lecture(
        "Lecture 1: How to make a gamified game",
        DateTime(2023, DateTime.march, 3, 11, 00),
        DateTime(2023, DateTime.march, 3, 13, 00),
        [john],
      ),
      Lecture(
        "Lecture 2: How to use points",
        DateTime(2023, DateTime.march, 10, 11, 00),
        DateTime(2023, DateTime.march, 10, 13, 00),
        [john],
      ),
      Lecture(
        "Lecture 3: How to use badges",
        DateTime(2023, DateTime.march, 17, 11, 00),
        DateTime(2023, DateTime.march, 17, 13, 00),
        [john],
      ),
      Lecture(
        "Lecture 4: How to use leaderboards",
        DateTime(2023, DateTime.march, 24, 11, 00),
        DateTime(2023, DateTime.march, 24, 13, 00),
        [john],
      ),
      Lecture(
        "Lecture 5: How to use achievements",
        DateTime(2023, DateTime.march, 31, 11, 00),
        DateTime(2023, DateTime.march, 31, 13, 00),
        [john],
      ),
      Lecture(
        "Lecture 6: How to use quests",
        DateTime(2023, DateTime.april, 7, 11, 00),
        DateTime(2023, DateTime.april, 7, 13, 00),
        [john],
      ),
    ],
  ),
  Course(
    "VFX",
    [Audience.artist],
    [
      Lecture(
        "Lecture 1: How to make a VFX game",
        DateTime(2023, DateTime.march, 2, 12, 00),
        DateTime(2023, DateTime.march, 2, 14, 00),
        [john],
      ),
      Lecture(
        "Lecture 2: How to use particles",
        DateTime(2023, DateTime.march, 9, 12, 00),
        DateTime(2023, DateTime.march, 9, 14, 00),
        [john],
      ),
      Lecture(
        "Lecture 3: How to use shaders",
        DateTime(2023, DateTime.march, 16, 12, 00),
        DateTime(2023, DateTime.march, 16, 14, 00),
        [john],
      ),
      Lecture(
        "Lecture 4: How to use post processing",
        DateTime(2023, DateTime.march, 23, 12, 00),
        DateTime(2023, DateTime.march, 23, 14, 00),
        [john],
      ),
      Lecture(
        "Lecture 5: How to use lighting",
        DateTime(2023, DateTime.march, 30, 12, 00),
        DateTime(2023, DateTime.march, 30, 14, 00),
        [john],
      ),
      Lecture(
        "Lecture 6: How to use animation",
        DateTime(2023, DateTime.april, 6, 11, 00),
        DateTime(2023, DateTime.april, 6, 13, 00),
        [john],
      ),
    ],
  ),
  Course(
    "3D Animation",
    [Audience.artist],
    [
      Lecture(
        "Lecture 1: How to make a 3D game",
        DateTime(2023, DateTime.march, 3, 12, 00),
        DateTime(2023, DateTime.march, 3, 14, 00),
        [john],
      ),
      Lecture(
        "Lecture 2: How to use animation",
        DateTime(2023, DateTime.march, 10, 12, 00),
        DateTime(2023, DateTime.march, 10, 14, 00),
        [john],
      ),
      Lecture(
        "Lecture 3: How to use rigging",
        DateTime(2023, DateTime.march, 17, 12, 00),
        DateTime(2023, DateTime.march, 17, 14, 00),
        [john],
      ),
      Lecture(
        "Lecture 4: How to use IK",
        DateTime(2023, DateTime.march, 24, 12, 00),
        DateTime(2023, DateTime.march, 24, 14, 00),
        [john],
      ),
      Lecture(
        "Lecture 5: Blender is better than Maya, btw",
        DateTime(2023, DateTime.march, 31, 12, 00),
        DateTime(2023, DateTime.march, 31, 14, 00),
        [john],
      ),
      Lecture(
        "Lecture 6: How to make bones",
        DateTime(2023, DateTime.april, 7, 12, 00),
        DateTime(2023, DateTime.april, 7, 14, 00),
        [john],
      ),
    ],
  ),
];

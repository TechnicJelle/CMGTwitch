import "models/audience.dart";
import "models/chat_message.dart";
import "models/course.dart";
import "models/lecture.dart";
import "models/person.dart";

Person you = Person("You");

Person _john = Person(
  "John",
  "https://media.discordapp.net/attachments/771451216499965953/1079147761410261234/fmsvan7jjxia1.jpg",
);
Person _claudia = Person("Claudia");
Person _longJohn = Person("Long John");

List<ChatMessage> _mockChat = [
  ChatMessage(
    "Hello!",
    _john,
    DateTime(2023, DateTime.january, 30, 9, 00, 00),
  ),
  ChatMessage(
    "Hi!",
    _claudia,
    DateTime(2023, DateTime.january, 30, 9, 00, 10),
  ),
  ChatMessage(
    "How are you?",
    _john,
    DateTime(2023, DateTime.january, 30, 9, 00, 20),
  ),
  ChatMessage(
    "I'm fine, thanks!",
    _claudia,
    DateTime(2023, DateTime.january, 30, 9, 00, 30),
  ),
  ChatMessage(
    "What are you doing?",
    _john,
    DateTime(2023, DateTime.january, 30, 9, 00, 40),
  ),
  ChatMessage(
    "I'm watching a lecture!",
    _claudia,
    DateTime(2023, DateTime.january, 30, 9, 00, 50),
  ),
  ChatMessage(
    "Cool!",
    _john,
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
        [_john],
        chat: _mockChat,
        tags: ["Buttons", "Navigation", "UI/UX"],
      ),
      Lecture(
        "Lecture 2: How to make your UI look good",
        DateTime(2023, DateTime.february, 2, 11, 00),
        DateTime(2023, DateTime.february, 2, 13, 00),
        [_john, _claudia],
      ),
      Lecture(
        "Lecture 3: How to make your UI not look like a 90s website",
        DateTime(2023, DateTime.february, 6, 8, 30),
        DateTime(2023, DateTime.february, 6, 10, 30),
        [_john],
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
        [_john],
      ),
      Lecture(
        "Lec02: Lighting and Shadows",
        DateTime(2023, DateTime.february, 6, 10, 30),
        DateTime(2023, DateTime.february, 6, 12, 30),
        [_john],
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
        [_john],
      ),
      Lecture(
        "Lecture 2: How to design good levels and UI without looking like an absolute doofus",
        DateTime(2023, DateTime.february, 2, 10, 00),
        DateTime(2023, DateTime.february, 2, 12, 00),
        [_john],
      ),
      Lecture(
        "Lecture 3: How to make your game look good with VFX",
        DateTime(2023, DateTime.february, 6, 11, 00),
        DateTime(2023, DateTime.february, 6, 12, 30),
        [_john],
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
        [_john],
      ),
      Lecture(
        "Lec2: Blender advanced",
        DateTime(2023, DateTime.february, 2, 9, 00),
        DateTime(2023, DateTime.february, 2, 11, 00),
        [_john],
      ),
      Lecture(
        "Lec3: Blender compositing",
        DateTime(2023, DateTime.february, 6, 16, 00),
        DateTime(2023, DateTime.february, 6, 18, 00),
        [_john],
      ),
    ],
  ),
];

import 'package:intl/intl.dart';

DateFormat _timeFormHHmmss = DateFormat("HH:mm:ss");

class ChatMessage {
  String text;
  String sender;
  DateTime time;

  String get timeStr => _timeFormHHmmss.format(time);

  ChatMessage(this.text, this.sender, this.time);
}

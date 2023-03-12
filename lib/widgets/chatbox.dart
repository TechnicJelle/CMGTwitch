import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../lecture_db.dart";
import "../main.dart";
import "../models/chat_message.dart";
import "../models/lecture.dart";
import "../models/person.dart";

final chatboxFocusStatusProvider = StateProvider<bool>((_) => false);

class Chatbox extends ConsumerStatefulWidget {
  final Lecture lecture;

  const Chatbox(this.lecture, {super.key});

  @override
  ConsumerState<Chatbox> createState() => _ChatboxState();
}

class _ChatboxState extends ConsumerState<Chatbox> {
  Lecture get lecture => widget.lecture;
  late List<ChatMessage> chat;

  final FocusNode _chatFocusNode = FocusNode();
  final TextEditingController _chatController = TextEditingController();

  Timer? timer; //only used for live lectures, so it's nullable

  @override
  void initState() {
    super.initState();

    chat = lecture.chat.reversed.toList();

    //on focus change, update the provider
    _chatFocusNode.addListener(() {
      ref.read(chatboxFocusStatusProvider.notifier).state =
          _chatFocusNode.hasFocus;
    });

    if (lecture.isLive) {
      //Send a welcome message when the user joins,
      // and after that, send a periodic "spam" message.
      Person spammer = Person(
        "Random Spammy Person",
        "https://picsum.photos/seed/${DateTime.now().millisecondsSinceEpoch}/128/128",
      );

      timer = Timer(const Duration(seconds: 1), () {
        sendChatMessage(
            ChatMessage("Welcome to the lecture!", spammer, DateTime.now()));
        int count = 1;
        timer = Timer.periodic(const Duration(seconds: 6), (timer) {
          DateTime now = DateTime.now();
          sendChatMessage(
              ChatMessage("Periodic chat message $count", spammer, now));
          count++;
        });
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _chatController.dispose();
    _chatFocusNode.dispose();
    timer?.cancel();
  }

  void sendChatMessage(ChatMessage message) {
    setState(() {
      lecture.chat.add(message);
      chat = lecture.chat.reversed.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              lecture.isLive ? "Live Chat" : "Chat (Replay)",
              style: midnightKernboyHeaders,
            ),
          ),
          Expanded(
            child: Material(
              type: MaterialType.transparency,
              child: ListView.separated(
                reverse: true,
                itemCount: chat.length,
                itemBuilder: (context, index) {
                  ChatMessage msg = chat[index];

                  return ListTile(
                      leading: msg.sender.avatar,
                      title: Text(
                        "${msg.sender.name} ${lecture.speakers.contains(msg.sender) ? " (Speaker)" : ""}",
                        style: auto1ImportantBody,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          msg.text,
                          style: auto1NormalBody,
                        ),
                      ),
                      minVerticalPadding: 6,
                      trailing: Text(
                        msg.timeStr,
                        style: auto1NormalBody.copyWith(color: Colors.grey),
                      ),
                      tileColor: (msg.sender == you)
                          ? Colors.greenAccent[200]?.withOpacity(0.05)
                          : (lecture.speakers.contains(msg.sender))
                              ? Colors.blueAccent[200]?.withOpacity(0.1)
                              : null);
                },
                separatorBuilder: (context, index) => const Divider(height: 0),
              ),
            ),
          ),
          if (lecture.isLive)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _chatController,
                focusNode: _chatFocusNode,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Message",
                ),
                onSubmitted: (String msg) {
                  if (msg.isEmpty) return;
                  setState(() {
                    sendChatMessage(ChatMessage(msg, you, DateTime.now()));
                  });
                  _chatController.clear();
                  _chatFocusNode.requestFocus();
                },
              ),
            ),
        ],
      ),
    );
  }
}

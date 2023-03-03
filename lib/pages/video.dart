import 'dart:async';
import 'dart:html';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../lecture_db.dart';
import '../main.dart';
import '../models/chat_message.dart';
import '../models/lecture.dart';
import '../models/person.dart';

class VideoPage extends StatefulWidget {
  const VideoPage(this.lecture, {super.key});

  final Lecture lecture;

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  Lecture get lecture => widget.lecture;

  late FlickManager flickManager;

  final FocusNode _chatFocusNode = FocusNode();
  final TextEditingController _chatController = TextEditingController();

  final ScrollController _chatScrollController = ScrollController();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
      ),
      autoPlay: false,
      onVideoEnd: () {
        print("Video ended");
      },
      getPlayerControlsTimeout: (
          {errorInVideo, isPlaying, isVideoEnded, isVideoInitialized}) {
        if (errorInVideo != null && errorInVideo) {
          flickManager.flickVideoManager?.videoPlayerController?.initialize();
        }
        return const Duration(seconds: 3);
      },
    );

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

      // sendRandomMessage(timer!);
    }
  }

  @override
  void dispose() {
    super.dispose();
    flickManager.dispose();
    _chatController.dispose();
    _chatFocusNode.dispose();
    _chatScrollController.dispose();
    timer?.cancel();
  }

  void sendChatMessage(ChatMessage message) {
    setState(() {
      lecture.chat.add(message);
      if (_chatScrollController.position.maxScrollExtent -
              _chatScrollController.offset <
          100) {
        _chatScrollController
            .jumpTo(_chatScrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: logoCMGTwitch(),
        elevation: 8,
      ),
      body: Row(
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: FlickVideoPlayer(
                    flickManager: flickManager,
                    flickVideoWithControls: const FlickVideoWithControls(
                      controls: FlickLandscapeControls(),
                      videoFit: BoxFit.contain,
                    ),
                    webKeyDownHandler: (KeyboardEvent event, FlickManager mgr) {
                      if (_chatFocusNode.hasFocus) return;

                      const Duration sec10 = Duration(seconds: 10);
                      if (event.keyCode == 70) {
                        mgr.flickControlManager?.toggleFullscreen();
                        mgr.flickDisplayManager?.handleShowPlayerControls();
                      } else if (event.keyCode == 77) {
                        mgr.flickControlManager?.toggleMute();
                        mgr.flickDisplayManager?.handleShowPlayerControls();
                      } else if (event.keyCode == 39) {
                        mgr.flickControlManager?.seekForward(sec10);
                        mgr.flickDisplayManager?.handleShowPlayerControls();
                      } else if (event.keyCode == 37) {
                        mgr.flickControlManager?.seekBackward(sec10);
                        mgr.flickDisplayManager?.handleShowPlayerControls();
                      } else if (event.keyCode == 32) {
                        mgr.flickControlManager?.togglePlay();
                        mgr.flickDisplayManager?.handleShowPlayerControls();
                      } else if (event.keyCode == 38) {
                        mgr.flickControlManager?.increaseVolume(0.05);
                        mgr.flickDisplayManager?.handleShowPlayerControls();
                      } else if (event.keyCode == 40) {
                        mgr.flickControlManager?.decreaseVolume(0.05);
                        mgr.flickDisplayManager?.handleShowPlayerControls();
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    lecture.title,
                    style: midnightKernboyHeaders,
                  ),
                ),
              ],
            ),
          ),
          if (lecture.chat.isNotEmpty || lecture.isLive) buildChatBox(),
        ],
      ),
    );
  }

  Widget buildChatBox() {
    List<ChatMessage> chat = lecture.chat;

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
                controller: _chatScrollController,
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

import 'dart:html';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../main.dart';
import '../models/chat_message.dart';
import '../models/lecture.dart';

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
  }

  @override
  void dispose() {
    super.dispose();
    flickManager.dispose();
    _chatController.dispose();
    _chatFocusNode.dispose();
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
    return SizedBox(
      width: 400,
      child: Column(
        children: [
          Text(
            "Chat${lecture.isLive ? "" : " (Replay)"}",
            style: midnightKernboyHeaders,
          ),
          Expanded(
            child: ListView.separated(
              itemCount: lecture.chat.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text(
                      lecture.chat[index].sender[0],
                      style: midnightKernboyHeaders,
                    ),
                  ),
                  title: Text(
                    lecture.chat[index].sender,
                    style: auto1ImportantBody,
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      lecture.chat[index].text,
                      style: auto1NormalBody,
                    ),
                  ),
                  minVerticalPadding: 0,
                  trailing: Text(
                    lecture.chat[index].timeStr,
                    style: auto1NormalBody.copyWith(color: Colors.grey),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
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
                  setState(() {
                    lecture.chat.add(ChatMessage(msg, "You", DateTime.now()));
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

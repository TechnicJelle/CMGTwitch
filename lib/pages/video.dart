import "dart:html";

import "package:flick_video_player/flick_video_player.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:video_player/video_player.dart";

import "../main.dart";
import "../models/lecture.dart";
import "../widgets/chatbox.dart";

class VideoPage extends ConsumerStatefulWidget {
  const VideoPage(this.lecture, {super.key});

  final Lecture lecture;

  @override
  ConsumerState<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends ConsumerState<VideoPage> {
  Lecture get lecture => widget.lecture;

  late FlickManager flickManager;

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(setState),
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
                      bool isChatboxFocused =
                          ref.read(chatboxFocusStatusProvider);
                      if (isChatboxFocused) return;

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
          if (lecture.chat.isNotEmpty || lecture.isLive) Chatbox(lecture),
        ],
      ),
    );
  }
}

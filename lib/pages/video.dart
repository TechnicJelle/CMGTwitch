import "dart:html";

import "package:cached_network_image/cached_network_image.dart";
import "package:flick_video_player/flick_video_player.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:video_player/video_player.dart";

import "../main.dart";
import "../models/lecture.dart";
import "../widgets/chatbox.dart";

class VideoPage extends StatefulWidget {
  const VideoPage(this.lecture, {super.key});

  final Lecture lecture;

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  Lecture get lecture => widget.lecture;

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
                  child: _Video(lecture),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Hero(
                    tag: lecture.title,
                    child: Material(
                      type: MaterialType.transparency,
                      child: Text(
                        lecture.title,
                        style: midnightKernboyHeaders,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                // TODO: Description and more details stuff
              ],
            ),
          ),
          if (lecture.chat.isNotEmpty || lecture.isLive) Chatbox(lecture),
        ],
      ),
    );
  }
}

class _Video extends ConsumerWidget {
  final Lecture lecture;
  late final FlickManager flickManager;

  _Video(this.lecture) {
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
      ),
      autoPlay: false,
      onVideoEnd: () {
        debugPrint("Video ended");
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
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Hero(
          tag: lecture.thumbnail,
          child: CachedNetworkImage(
            imageUrl: lecture.thumbnail,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        FlickVideoPlayer(
          flickManager: flickManager,
          flickVideoWithControls: const FlickVideoWithControls(
            controls: FlickLandscapeControls(),
            videoFit: BoxFit.contain,
          ),
          webKeyDownHandler: (KeyboardEvent event, FlickManager manager) {
            bool isChatboxFocused = ref.read(chatboxFocusStatusProvider);
            if (isChatboxFocused) return;

            const Duration sec10 = Duration(seconds: 10);
            if (event.keyCode == 70) {
              manager.flickControlManager?.toggleFullscreen();
              manager.flickDisplayManager?.handleShowPlayerControls();
            } else if (event.keyCode == 77) {
              manager.flickControlManager?.toggleMute();
              manager.flickDisplayManager?.handleShowPlayerControls();
            } else if (event.keyCode == 39) {
              manager.flickControlManager?.seekForward(sec10);
              manager.flickDisplayManager?.handleShowPlayerControls();
            } else if (event.keyCode == 37) {
              manager.flickControlManager?.seekBackward(sec10);
              manager.flickDisplayManager?.handleShowPlayerControls();
            } else if (event.keyCode == 32) {
              manager.flickControlManager?.togglePlay();
              manager.flickDisplayManager?.handleShowPlayerControls();
            } else if (event.keyCode == 38) {
              manager.flickControlManager?.increaseVolume(0.05);
              manager.flickDisplayManager?.handleShowPlayerControls();
            } else if (event.keyCode == 40) {
              manager.flickControlManager?.decreaseVolume(0.05);
              manager.flickDisplayManager?.handleShowPlayerControls();
            }
          },
        ),
      ],
    );
  }
}

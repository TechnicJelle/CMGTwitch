import "dart:html";

import "package:cached_network_image/cached_network_image.dart";
import "package:flick_video_player/flick_video_player.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:video_player/video_player.dart";

import "../main.dart";
import "../models/lecture.dart";
import "../widgets/chatbox.dart";
import "../widgets/lecture_card.dart";

class VideoPage extends StatefulWidget {
  const VideoPage(this.lecture, {super.key});

  final Lecture lecture;

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  Lecture get lecture => widget.lecture;

  bool _handRaised = false;

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
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LectureTitle(lecture),
                              const SizedBox(height: 4),
                              Speakers(lecture),
                              const SizedBox(height: 4),
                              const Text(
                                "Description\n"
                                "With multiple lines",
                                style: auto1NormalBody,
                              ),
                              const SizedBox(height: 4),
                              if (lecture.tags.isNotEmpty) Tags(lecture),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (lecture.isLive)
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _handRaised = !_handRaised;
                          });
                        },
                        icon: Icon(
                          _handRaised
                              ? Icons.front_hand
                              : Icons.front_hand_outlined,
                          color: _handRaised ? red : null,
                        ),
                      )
                  ],
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

class _Video extends ConsumerWidget {
  final Lecture lecture;
  late final FlickManager flickManager;

  _Video(this.lecture) {
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
      ),
      autoPlay: lecture.isLive,
      onVideoEnd: () {
        if (lecture.isLive) {
          flickManager.flickControlManager?.replay();
        }
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

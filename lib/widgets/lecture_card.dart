import "dart:math";

import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";

import "../models/audience.dart";
import "../models/lecture.dart";
import "../main.dart";
import "../models/person.dart";

class LectureCard extends StatefulWidget {
  final Lecture lecture;
  final List<Audience>? audience;

  const LectureCard(this.lecture, {this.audience, super.key});

  @override
  State<LectureCard> createState() => _LectureCardState();
}

class _LectureCardState extends State<LectureCard> {
  Lecture get lecture => widget.lecture;
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Thumbnail(lecture, _isHovering, audience: widget.audience),
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 6, 4, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Title(lecture),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: _Speakers(lecture),
                    ),
                    if (lecture.tags.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: _Tags(lecture),
                      ),
                  ],
                ),
              ),
            ],
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => lecture.watch(context),
                onHover: (bool isHovering) =>
                    setState(() => _isHovering = isHovering),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Thumbnail extends StatelessWidget {
  final Lecture lecture;
  final bool _isHovering;
  final List<Audience>? audience;

  const _Thumbnail(this.lecture, this._isHovering, {this.audience});

  @override
  Widget build(BuildContext context) => Stack(
        alignment: Alignment.center,
        children: [
          Hero(
            tag: lecture.thumbnail + _unAlive(lecture),
            child: CachedNetworkImage(
              imageUrl: lecture.thumbnail,
              fit: BoxFit.cover,
              fadeInDuration: const Duration(milliseconds: 200),
              fadeOutDuration: const Duration(milliseconds: 100),
              progressIndicatorBuilder: (context, String url, progress) {
                return SizedBox(
                  height: 280,
                  width: double.infinity,
                  child: Center(
                    child: SizedBox.square(
                      dimension: 32,
                      child: CircularProgressIndicator(
                        value: progress.progress,
                      ),
                    ),
                  ),
                );
              },
              errorWidget: (context, String url, error) {
                debugPrint(error);
                return const SizedBox(
                  height: 280,
                  width: double.infinity,
                  child: Icon(Icons.error),
                );
              },
            ),
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: Theme(
              data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
              child: Chip(
                label: lecture.isLive
                    ? Row(
                        children: [
                          const Icon(Icons.circle, color: Colors.red, size: 12),
                          const SizedBox(width: 2),
                          Text(
                            "Live",
                            style: auto1NormalBody.copyWith(color: Colors.red),
                          ),
                        ],
                      )
                    : Text(
                        lecture.durationString,
                        style: auto1NormalBody.copyWith(color: white),
                      ),
                backgroundColor: black.withOpacity(0.6),
              ),
            ),
          ),
          if (audience != null)
            Positioned(
              bottom: 8,
              left: 8,
              child: Row(
                children: [
                  for (Audience audience in audience!)
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: audience.icon,
                    ),
                ],
              ),
            ),
          if (_isHovering)
            const Icon(
              Icons.play_circle_outline,
              color: white,
              shadows: [Shadow(color: black, blurRadius: 8)],
              size: 48,
            ),
        ],
      );
}

class _Title extends StatelessWidget {
  final Lecture lecture;

  const _Title(this.lecture);

  @override
  Widget build(BuildContext context) => Hero(
        tag: lecture.title + _unAlive(lecture),
        child: Material(
          type: MaterialType.transparency,
          child: Text(
            lecture.title,
            style: midnightKernboyHeaders,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
}

class _Speakers extends StatelessWidget {
  final Lecture lecture;

  const _Speakers(this.lecture);

  @override
  Widget build(BuildContext context) => Wrap(
        spacing: 4,
        runSpacing: 4,
        children: [
          for (Person speaker in lecture.speakers)
            Chip(
              label: Text(speaker.name,
                  style: auto1NormalBody.copyWith(color: white)),
              backgroundColor: black.withOpacity(0.6),
              avatar: speaker.avatar,
            ),
        ],
      );
}

class _Tags extends StatelessWidget {
  final Lecture lecture;

  const _Tags(this.lecture);

  @override
  Widget build(BuildContext context) => Wrap(
        spacing: 4,
        runSpacing: 4,
        children: [
          for (String tag in lecture.tags)
            Chip(
              label: Text(tag, style: auto1NormalBody.copyWith(color: white)),
              backgroundColor: black.withOpacity(0.6),
            ),
        ],
      );
}

//TODO: This is a hack to prevent the hero animation from playing on live lectures.
// This is because live lectures are duplicated in the list, and the hero animation
// is triggered by the same tag on both widgets, which of course breaks the Hero widget,
// which only allows one hero per tag.
String _unAlive(Lecture lecture) =>
    (lecture.isLive ? Random().nextDouble().toString() : "");

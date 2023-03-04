import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/lecture.dart';
import '../main.dart';
import '../models/person.dart';

class LectureCard extends StatefulWidget {
  const LectureCard(this.lecture, {super.key});

  final Lecture lecture;

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
              buildThumbnail(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: buildTitle(),
              ),
              buildSpeakers(),
            ],
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => lecture.watch(context),
                onHover: (isHovering) =>
                    setState(() => _isHovering = isHovering),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildThumbnail() => Stack(
        alignment: Alignment.center,
        children: [
          CachedNetworkImage(
            imageUrl: 'https://picsum.photos/seed/${lecture.hashCode}/800/450',
            fit: BoxFit.cover,
            fadeInDuration: const Duration(milliseconds: 200),
            fadeOutDuration: const Duration(milliseconds: 100),
            progressIndicatorBuilder: (context, url, progress) {
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
            errorWidget: (context, url, error) {
              print(error);
              return const SizedBox(
                height: 280,
                width: double.infinity,
                child: Icon(Icons.error),
              );
            },
          ),
          if (_isHovering)
            const Icon(
              Icons.play_circle_outline,
              color: white,
              shadows: [Shadow(color: black, blurRadius: 8)],
              size: 48,
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
                        lecture.duration,
                        style: auto1NormalBody.copyWith(color: white),
                      ),
                backgroundColor: black.withOpacity(0.6),
              ),
            ),
          ),
        ],
      );

  Widget buildTitle() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lecture.title,
            style: midnightKernboyHeaders,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (lecture.tags.isNotEmpty) buildTags(),
        ],
      );

  Widget buildTags() => Padding(
        padding: const EdgeInsets.only(top: 4, bottom: 2),
        child: Wrap(
          spacing: 4,
          runSpacing: 4,
          children: [
            for (String tag in lecture.tags)
              Chip(
                label: Text(tag, style: auto1NormalBody.copyWith(color: white)),
                backgroundColor: black.withOpacity(0.6),
              ),
          ],
        ),
      );

  Widget buildSpeakers() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Wrap(
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
      ));
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class VOD extends StatefulWidget {
  const VOD({super.key});

  @override
  State<VOD> createState() => _VODState();
}

class _VODState extends State<VOD> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "VOD Lectures",
          style: midnightKernboyTitles,
        ),
        Flexible(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 500,
              childAspectRatio: 16 / 9,
            ),
            itemCount: 50,
            itemBuilder: (context, index) => buildImageInteractionCard(index),
          ),
        ),
      ],
    );
  }

  Widget buildImageInteractionCard(int index) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: 'https://picsum.photos/seed/${index + 1}/500',
            fit: BoxFit.cover,
            fadeInDuration: const Duration(milliseconds: 200),
            fadeOutDuration: const Duration(milliseconds: 100),
            progressIndicatorBuilder: (context, url, progress) => Center(
              child: CircularProgressIndicator(
                value: progress.progress,
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              'Cats rule the world!',
              style: midnightKernboyHeaders,
            ),
          ),
        ],
      ),
    );
  }
}

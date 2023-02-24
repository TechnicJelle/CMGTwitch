import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class VOD extends StatefulWidget {
  const VOD({super.key});

  @override
  State<VOD> createState() => _VODState();
}

class _VODState extends State<VOD> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildTopBar(),
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

  Widget buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            child: Material(
              borderRadius: BorderRadius.circular(8),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                controller: _searchController,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  hintText: "Search",
                  prefixIcon: const Icon(Icons.search),
                  contentPadding: const EdgeInsets.all(0),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            _searchController.clear();
                            searchItems("");
                            FocusScope.of(context).unfocus();
                          },
                        )
                      : null,
                ),
                onChanged: (String s) => setState(() => searchItems(s)),
              ),
            ),
          ),
          const SizedBox(width: 3),
          SizedBox(
            width: 48,
            height: 48,
            child: Tooltip(
              message: "Sort",
              child: RawMaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                fillColor: Theme.of(context).cardColor,
                child: const Icon(Icons.sort),
                onPressed: () {
                  // _changeSortDialog(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void searchItems(String s) {}
}

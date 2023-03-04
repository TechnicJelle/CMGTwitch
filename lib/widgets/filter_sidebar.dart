import "package:flutter/material.dart";
import "package:equatable/equatable.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../main.dart";

final filterStatusProvider =
    StateProvider<FilterStatus>((_) => const FilterStatus());

@immutable
class FilterStatus extends Equatable {
  final bool engineers, designers, artists;

  const FilterStatus({
    this.engineers = true,
    this.designers = true,
    this.artists = true,
  });

  /// Whether any filters are active.
  bool get filterActive => this != const FilterStatus(); //compare to default

  @override
  //for the comparison in filterActive
  List<Object?> get props => [
        engineers,
        designers,
        artists,
      ];

  FilterStatus copyWith({
    bool? engineers,
    bool? designers,
    bool? artists,
  }) {
    return FilterStatus(
      engineers: engineers ?? this.engineers,
      designers: designers ?? this.designers,
      artists: artists ?? this.artists,
    );
  }
}

class FilterSidebar extends ConsumerWidget {
  const FilterSidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FilterStatus status = ref.watch(filterStatusProvider);

    return Container(
      color: Theme.of(context).cardColor,
      width: 300,
      child: ListView(
        children: [
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text("Filter", style: midnightKernboyTitles),
              ),
              TextButton(
                onPressed: status.filterActive
                    ? () => ref.refresh(filterStatusProvider)
                    : null,
                child: Text(
                  "Clear Filters",
                  style: auto1ImportantBody.copyWith(
                      color: status.filterActive ? purple : Colors.grey),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          ListTile(
            title: const Text(
              "Target Audience",
              style: midnightKernboyHeaders,
            ),
            subtitle: Column(
              children: [
                CheckboxListTile(
                  title: const Text("Engineers", style: auto1NormalBody),
                  dense: true,
                  value: status.engineers,
                  onChanged: (bool? val) => ref
                      .read(filterStatusProvider.notifier)
                      .state = status.copyWith(engineers: val),
                ),
                CheckboxListTile(
                  title: const Text("Designers", style: auto1NormalBody),
                  dense: true,
                  value: status.designers,
                  onChanged: (bool? val) => ref
                      .read(filterStatusProvider.notifier)
                      .state = status.copyWith(designers: val),
                ),
                CheckboxListTile(
                  title: const Text("Artists", style: auto1NormalBody),
                  dense: true,
                  value: status.artists,
                  onChanged: (bool? val) => ref
                      .read(filterStatusProvider.notifier)
                      .state = status.copyWith(artists: val),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

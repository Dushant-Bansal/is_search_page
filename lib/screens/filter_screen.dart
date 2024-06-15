import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:is_search_page/models/filter.dart';
import 'package:is_search_page/providers/providers.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(internshipNotifierProvider);

    final availableFilters =
        ref.read(internshipNotifierProvider.notifier).availableFilterGroups;
    final appliedFilters =
        ref.read(internshipNotifierProvider.notifier).appliedFilters;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Close',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final filter in availableFilters)
              _buildFilterChip(
                ref,
                filter: filter,
                selectedFilters: appliedFilters,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(
    WidgetRef ref, {
    required FilterGroup filter,
    required List<FilterGroup> selectedFilters,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          filter.name,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: filter.filters.map(
            (value) {
              final filterGroup = selectedFilters
                  .firstWhere((element) => element.type == filter.type);
              return FilterChip(
                label: Text(value.name),
                selected: filterGroup.filters
                    .any((filter) => filter.name == value.name),
                showCheckmark: false,
                onSelected: (_) {
                  ref
                      .read(internshipNotifierProvider.notifier)
                      .applyFilter(value);
                },
              );
            },
          ).toList(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:is_search_page/providers/providers.dart';
import 'package:is_search_page/screens/filter_screen.dart';

class InternshipListScreen extends ConsumerStatefulWidget {
  const InternshipListScreen({super.key});

  @override
  ConsumerState<InternshipListScreen> createState() =>
      _InternshipListScreenState();
}

class _InternshipListScreenState extends ConsumerState<InternshipListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
            ref.read(internshipNotifierProvider.notifier).fetchInternships())
        .then((_) => FlutterNativeSplash.remove());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openFilters(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FiltersScreen()),
    );

    // clear the previous search query
    ref.read(internshipNotifierProvider.notifier).searchInternships('');
    _searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(internshipNotifierProvider);
    final filters = ref
        .read(internshipNotifierProvider.notifier)
        .appliedFilters
        .expand((e) => e.filters)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Internships'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_rounded),
            onPressed: () => _openFilters(context),
          ),
        ],
      ),
      body: provider.internships.when(
        data: (data) {
          if (provider.isEmpty) {
            return const Center(
              child: Text(
                'No internships available',
                style: TextStyle(fontSize: 20.0),
              ),
            );
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        isDense: true,
                        prefixIcon: const Icon(Icons.search_rounded, size: 24),
                        labelText: 'Search',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onChanged: (query) => ref
                          .read(internshipNotifierProvider.notifier)
                          .searchInternships(query),
                    ),
                    const SizedBox(height: 8.0),
                    Wrap(
                      spacing: 8.0,
                      children: filters
                          .map(
                            (filter) => Chip(
                              label: Text(filter.name),
                              onDeleted: () => ref
                                  .read(internshipNotifierProvider.notifier)
                                  .removeFilter(filter),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
              if (data.isEmpty)
                const Text('No internships found!')
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final internship = data.values.elementAt(index);
                      return Column(
                        children: [
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  internship.title,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.business, size: 20.0),
                                    const SizedBox(width: 8.0),
                                    Expanded(
                                      child: Text(
                                        internship.companyName,
                                        style: const TextStyle(fontSize: 16.0),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8.0),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on, size: 20.0),
                                    const SizedBox(width: 4.0),
                                    Text(
                                      internship.locationNames.isEmpty
                                          ? 'Remote'
                                          : internship.locationNames.join(", "),
                                      style: const TextStyle(fontSize: 16.0),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8.0),
                                Row(
                                  children: [
                                    const Icon(Icons.timer, size: 20.0),
                                    const SizedBox(width: 4.0),
                                    Text(
                                      internship.duration,
                                      style: const TextStyle(fontSize: 16.0),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8.0),
                                Row(
                                  children: [
                                    Icon(Icons.wallet, size: 20.0),
                                    const SizedBox(width: 4.0),
                                    Text(
                                      internship.stipend.salary,
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

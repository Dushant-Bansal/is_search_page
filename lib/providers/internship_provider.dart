import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:is_search_page/models/filter.dart';
import 'package:is_search_page/models/internship.dart';
import 'package:is_search_page/services/api_service.dart';

class InternshipState {
  final Map<String, Internship> allInternships;
  final AsyncValue<Map<String, Internship>> internships;

  bool get isEmpty => allInternships.isEmpty;

  InternshipState._({
    required this.allInternships,
    required this.internships,
  });

  factory InternshipState.initial() {
    return InternshipState._(
      allInternships: {},
      internships: const AsyncValue.loading(),
    );
  }

  InternshipState copyWith({
    Map<String, Internship>? allInternships,
    AsyncValue<Map<String, Internship>>? internships,
  }) {
    return InternshipState._(
      allInternships: allInternships ?? this.allInternships,
      internships: internships ?? this.internships,
    );
  }
}

class InternshipNotifier extends StateNotifier<InternshipState> {
  final ApiService apiService;

  // filters
  final List<FilterGroup> availableFilterGroups = [];

  final List<FilterGroup> appliedFilters = [
    ProfileFilters(filters: <Filter>[]),
    CityFilters(filters: <Filter>[]),
    DurationFilters(filters: <Filter>[]),
  ];

  InternshipNotifier(this.apiService) : super(InternshipState.initial());

  Future<void> fetchInternships() async {
    state = state.copyWith(internships: const AsyncValue.loading());
    try {
      final data = await apiService.fetchInternships();
      state = state.copyWith(
        allInternships: data.internships,
        internships: AsyncValue.data(data.internships),
      );

      final internships = data.internships;

      final profiles = internships.values
          .map((value) => value.profileName)
          .toSet()
          .map((value) => Filter(name: value, type: 'profile'))
          .toList();

      profiles.sort((a, b) => a.name.compareTo(b.name));

      final cities = internships.values
          .map((value) => value.locationNames)
          .expand((locations) => locations)
          .toSet()
          .map((value) => Filter(name: value, type: 'city'))
          .toList();

      cities.sort((a, b) => a.name.compareTo(b.name));

      final durations = internships.values
          .map((value) => value.duration)
          .toSet()
          .map((value) => Filter(name: value, type: 'duration'))
          .toList();

      durations.sort((a, b) => a.name.compareTo(b.name));

      availableFilterGroups.clear();
      availableFilterGroups.addAll(
        [
          ProfileFilters(filters: profiles),
          CityFilters(filters: cities),
          DurationFilters(filters: durations),
        ],
      );
    } catch (e, s) {
      state = state.copyWith(internships: AsyncValue.error(e, s));
    }
  }

  void searchInternships(String query) {
    _applyAllFilters();
    final data = state.internships.value;
    if (data == null || data.isEmpty) return;

    final searchResults = Map.fromEntries(
      data.entries.where(
        (entry) {
          final internship = entry.value;
          return internship.title.toLowerCase().contains(query.toLowerCase()) ||
              internship.companyName
                  .toLowerCase()
                  .contains(query.toLowerCase());
        },
      ).map((entry) => MapEntry(entry.key, entry.value)),
    );

    state = state.copyWith(internships: AsyncValue.data(searchResults));
  }

  void applyFilter(Filter filter) {
    final data = state.allInternships;
    if (data.isEmpty) return;

    final filterGroup =
        appliedFilters.firstWhere((value) => value.type == filter.type);

    if (filterGroup.filters.any((value) => value.name == filter.name)) {
      removeFilter(filter);
      return;
    }

    appliedFilters.remove(filterGroup);
    filterGroup.filters.add(filter);
    appliedFilters.add(filterGroup);

    _applyAllFilters();
  }

  void removeFilter(Filter filter) {
    final filterGroup =
        appliedFilters.firstWhere((value) => value.type == filter.type);
    appliedFilters.remove(filterGroup);
    filterGroup.filters.removeWhere((value) => value.name == filter.name);
    appliedFilters.add(filterGroup);
    _applyAllFilters();
  }

  void _applyAllFilters() {
    final data = state.allInternships;
    if (data.isEmpty) return;

    List<Internship> filtered = List.from(data.values);

    for (final filter in appliedFilters) {
      filtered = filter.filter(filtered);
    }

    final filteredInternships = Map.fromEntries(filtered
        .map((internship) => MapEntry(internship.id.toString(), internship)));
    state = state.copyWith(internships: AsyncValue.data(filteredInternships));
  }
}

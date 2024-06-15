import 'package:is_search_page/models/internship.dart';

class Filter {
  final String name;
  final String type;
  final bool applied;

  Filter({required this.name, required this.type, this.applied = false});
}

abstract class FilterGroup {
  final String name;
  final String type;
  final List<Filter> filters;

  String get all => 'All $name';

  FilterGroup(this.name, this.type, {required this.filters});

  List<Internship> filter(List<Internship> internships);
}

class ProfileFilters extends FilterGroup {
  ProfileFilters({required List<Filter> filters})
      : super('Profiles', 'profile', filters: filters);

  @override
  List<Internship> filter(List<Internship> internships) {
    if (filters.isEmpty) return internships;

    final filterNames = filters.map((e) => e.name.toLowerCase());

    return internships
        .where((internship) =>
            filterNames.contains(internship.profileName.toLowerCase()))
        .toList();
  }
}

class CityFilters extends FilterGroup {
  CityFilters({required List<Filter> filters})
      : super('Cities', 'city', filters: filters);

  @override
  List<Internship> filter(List<Internship> internships) {
    if (filters.isEmpty) return internships;

    final filterNames = filters.map((e) => e.name.toLowerCase());

    return internships
        .where((internship) => internship.locationNames
            .any((value) => filterNames.contains(value.toLowerCase())))
        .toList();
  }
}

class DurationFilters extends FilterGroup {
  DurationFilters({required List<Filter> filters})
      : super('Durations', 'duration', filters: filters);

  @override
  List<Internship> filter(List<Internship> internships) {
    if (filters.isEmpty) return internships;

    final filterNames = filters.map((e) => e.name.toLowerCase());

    return internships
        .where((internship) =>
            filterNames.contains(internship.duration.toLowerCase()))
        .toList();
  }
}

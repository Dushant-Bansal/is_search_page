import 'package:is_search_page/models/internship.dart';

class InternshipsMeta {
  final List<int> internshipIds;
  final Map<String, Internship> internships;

  InternshipsMeta({required this.internshipIds, required this.internships});

  factory InternshipsMeta.fromJson(Map<String, dynamic> json) {
    return InternshipsMeta(
      internshipIds: List<int>.from(json['internship_ids']),
      internships: (json['internships_meta'] as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, Internship.fromJson(value))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'internship_ids': internshipIds,
      'internships': internships,
    };
  }
}

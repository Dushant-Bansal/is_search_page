import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:is_search_page/providers/internship_provider.dart';
import 'package:is_search_page/services/api_service.dart';

final internshipServiceProvider = Provider<ApiService>((ref) => ApiService());

final internshipNotifierProvider =
    StateNotifierProvider<InternshipNotifier, InternshipState>((ref) {
  final internshipService = ref.read(internshipServiceProvider);
  return InternshipNotifier(internshipService);
});

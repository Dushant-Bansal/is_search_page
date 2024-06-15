import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:is_search_page/models/interships_meta.dart';

class ApiService {
  final String _baseUrl = "https://internshala.com";

  Future<InternshipsMeta> fetchInternships() async {
    try {
      final res = await http.get(Uri.parse('$_baseUrl/flutter_hiring/search'));
      final data = jsonDecode(res.body);

      return InternshipsMeta.fromJson(data);
    } catch (_) {
      throw Exception("Failed to load internships");
    }
  }
}

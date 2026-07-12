import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/research_model.dart';

Future<List<ResearchModel>> fetchRecentResearch({
  String query = 'artificial intelligence',
  int rows = 10,
}) async {
  final uri = Uri.parse(
    'https://api.crossref.org/works?query=$query&rows=$rows&sort=published&order=desc',
  );
  final response = await http.get(uri);

  if (response.statusCode != 200) {
    throw Exception('Failed to fetch research: ${response.statusCode}');
  }

  final body = jsonDecode(response.body) as Map<String, dynamic>;
  final items = (body['message']?['items'] as List?) ?? [];

  return items
      .map((item) => ResearchModel.fromJson(item as Map<String, dynamic>))
      .toList();
}

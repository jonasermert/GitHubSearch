import 'dart:convert';
import 'package:http/http.dart' as http;

class GitHubService {
  final String baseUrl = 'https://api.github.com';

  Future<List<dynamic>> searchRepositories(String query) async {
    final url = Uri.parse('$baseUrl/search/repositories?q=$query');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['items'];
    } else {
      throw Exception('Failed to search repositories');
    }
  }
}

import 'package:flutter/material.dart';
import 'github_service.dart';

class GitHubSearchPage extends StatefulWidget {
  @override
  _GitHubSearchPageState createState() => _GitHubSearchPageState();
}

class _GitHubSearchPageState extends State<GitHubSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];

  void _performSearch() {
    final query = _searchController.text;
    GitHubService().searchRepositories(query).then((results) {
      setState(() {
        _searchResults = results;
      });
    }).catchError((error) {
      print('Search error: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GitHub Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search repositories',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _performSearch,
            child: Text('Search'),
          ),
          Expanded(
            child: ListView(
              children: _searchResults.map((result) {
                return ListTile(
                  title: Text(result['name']),
                  subtitle: Text(result['description'] ?? 'No description'),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

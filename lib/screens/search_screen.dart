// lib/screens/search_screen.dart
import 'package:flutter/material.dart';
import 'dart:async';
import '../widgets/search_bar.dart';
import '../services/api_service.dart';
import '../widgets/components/search_result.dart';
import '../models/post.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
//   String _searchQuery = "";
  final ApiService _apiService = ApiService();

  String _searchQuery = "";
  // List<Post> _searchResults = [];
  Post? _searchResult;
  bool _isLoading = false;
  String? _errorMessage;

  Timer? _debounce;

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }



  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (query.isEmpty) {
        setState(() {
          _searchQuery = "";
          _searchResult = null;
          // _searchResults = [];
          _errorMessage = null;
        });
        return;
      }

      setState(() {
        _searchQuery = query;
        _isLoading = true;
        _errorMessage = null;
      });

      try {
        final postId = int.tryParse(query);
        if (postId == null) {
          setState(() {
            // _searchResults = [];
            _searchResult = null;
            _isLoading = false;
            _errorMessage = "Please enter a valid post ID (number)";
          });
          return;
        }

        final results = await _apiService.fetchSinglePosts(postId);
        setState(() {
          _searchResult = results;
          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _errorMessage = "Failed to load posts: $e";
          _isLoading = false;
        });
      }
    });
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchBarWidget(
              controller: _searchController,
              onChanged: _onSearchChanged,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _errorMessage != null
                      ? Center(child: Text(_errorMessage!))
                      : _searchResult == null
                          ? Center(
                              child: Text(
                                _searchQuery.isEmpty
                                    ? "Start typing post ID to search..."
                                    : "No results found for '$_searchQuery'",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            )
                          : SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text('Post ID: ${_searchResult!.id}'),
                                  SearchResult(post: _searchResult!),
                                ],
                              ),
                            ),
            ),
          ],
        ),
      ),
    ),
  );
}


}




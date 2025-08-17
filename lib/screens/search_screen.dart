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
  List<Post> _searchResults = [];
  bool _isLoading = false;
  String? _errorMessage;

  Timer? _debounce;

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

//   void _onSearchChanged(String query) {
//     setState(() {
//       _searchQuery = query;
//     });
//   }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (query.isEmpty) {
        setState(() {
          _searchQuery = "";
          _searchResults = [];
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
            _searchResults = [];
            _isLoading = false;
            _errorMessage = "Please enter a valid post ID (number)";
          });
          return;
        }

        final results = await _apiService.fetchSinglePosts(postId);
        setState(() {
          _searchResults = results;
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
            // Placeholder for search results
            // Expanded(
            //   child: Center(
            //     child: Text(
            //       _searchQuery.isEmpty
            //           ? "Start typing to search..."
            //           : "Searching for: '$_searchQuery'",
            //       style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            //     ),
            //   ),
            // ),
            Expanded(
  child: _isLoading
      ? const Center(child: CircularProgressIndicator())
      : _errorMessage != null
          ? Center(child: Text(_errorMessage!))
          : _searchResults.isEmpty
              ? Center(
                  child: Text(
                    _searchQuery.isEmpty
                        ? "Start typing post ID to search..."
                        : "No results found for '$_searchQuery'",
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                )
              : ListView.builder(
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    final post = _searchResults[index];
                    return SearchResult(post: post);
                    // return Card(
                    //   margin: const EdgeInsets.symmetric(vertical: 8),
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(16.0),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Text(
                    //           post.title,
                    //           style: const TextStyle(
                    //             fontSize: 18,
                    //             fontWeight: FontWeight.bold,
                    //           ),
                    //         ),
                    //         const SizedBox(height: 8),
                    //         Text(post.body),
                    //       ],
                    //     ),
                    //   ),
                    // );
                  },
                ),
),


          ],
        ),
      ),
    ),
  );
}

}


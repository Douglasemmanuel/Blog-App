import 'package:flutter/material.dart';

class PostDetailScreen extends StatelessWidget {
  final String postId;

  const PostDetailScreen({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Text(
          'Details for post ID: $postId',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}


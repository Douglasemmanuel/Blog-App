
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/post.dart';
import '../../widgets/post_card.dart';
import '../../providers/posts_provider.dart';

class PostsListScreen extends ConsumerWidget {
   final ScrollController scrollController;

  const PostsListScreen({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsync = ref.watch(postsProvider);

    return Scaffold(
    //   appBar: AppBar(title: const Text('All Posts')),
      body: postsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (posts) {
          if (posts.isEmpty) {
            return const Center(child: Text('No posts available.'));
          }

          return ListView.builder(
            controller: scrollController,
            itemCount: posts.length,
            itemBuilder: (context, index) => PostCard(post: posts[index]),
          );
        },
      ),
    );
  }
}
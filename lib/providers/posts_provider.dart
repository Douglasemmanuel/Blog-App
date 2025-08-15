import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/post.dart';
import '../services/api_service.dart';

class PostsNotifier extends AsyncNotifier<List<Post>> {
  @override
  Future<List<Post>> build() async {
    return ref.read(apiServiceProvider).fetchPosts();
  }

  Future<void> addPost(Post post) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(apiServiceProvider).createPost(post);
      return ref.read(apiServiceProvider).fetchPosts();
    });
  }
  
  // You can add updatePost & deletePost similarly
}

final postsProvider = AsyncNotifierProvider<PostsNotifier, List<Post>>(PostsNotifier.new);

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/post.dart';
import '../services/api_service.dart';
import '../preferences/post_storage.dart';

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

// final createdPostProvider = StateProvider<Post?>((ref) => null);
final createdPostProvider = StateNotifierProvider<CreatedPostNotifier, Post?>((ref) {
  return CreatedPostNotifier(null);
});



class CreatedPostNotifier extends StateNotifier<Post?> {
  // CreatedPostNotifier() : super(null) {
  //   loadPost();
  // }
   CreatedPostNotifier(Post? initialPost) : super(initialPost);

  Future<void> setPost(Post post) async {
    state = post;
    await PostPreferences.savePost(post);
  }

  Future<void> loadPost() async {
    final post = await PostPreferences.loadPost();
    if (post != null) {
      state = post;
    }
  }

  Future<void> clearPost() async {
    state = null;
    await PostPreferences.clearPost();
  }
}
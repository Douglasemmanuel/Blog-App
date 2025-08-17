// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../models/comment.dart';
// import '../services/api_service.dart';
// import 'dart:async';


// class CommentsNotifier extends AsyncNotifier<List<Comment>> {
//   @override
//   FutureOr<List<Comment>> build(int postId) async {
//     return ref.read(apiServiceProvider).fetchComments(postId);
//   }
// }

// final commentsProvider = AsyncNotifierProvider.family<CommentsNotifier, List<Comment>, int>((ref, postId) => CommentsNotifier()..build(postId));

import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/comment.dart';
import '../services/api_service.dart';

// Use FamilyAsyncNotifier for providers with family arguments
class CommentsNotifier extends FamilyAsyncNotifier<List<Comment>, int> {
  @override
  FutureOr<List<Comment>> build(int postId) async {
    // Here, build takes the family argument directly
    return ref.read(apiServiceProvider).fetchComments(postId);
  }
}

// Define the provider using family, no manual build call
final commentsProvider = AsyncNotifierProvider.family<
  CommentsNotifier,
  List<Comment>,
  int
>(
  CommentsNotifier.new, // pass constructor without args
);

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/comment.dart';
import '../services/api_service.dart';


class CommentsNotifier extends AsyncNotifier<List<Comment>> {
  @override
  FutureOr<List<Comment>> build(int postId) async {
    return ref.read(apiServiceProvider).fetchComments(postId);
  }
}

final commentsProvider = AsyncNotifierProvider.family<CommentsNotifier, List<Comment>, int>((ref, postId) => CommentsNotifier()..build(postId));

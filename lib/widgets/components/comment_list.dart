import 'package:flutter/material.dart';
import '../../widgets/comment_card.dart';
import '../../widgets/loading_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/comment.dart';
import '../../providers/comments_provider.dart';
class CommentList extends ConsumerWidget {
    final int postId;
  const CommentList({super.key , required this.postId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentsAsync = ref.watch(commentsProvider(postId));

    return commentsAsync.when(
      data: (comments) {
        if (comments.isEmpty) {
          return Center(
            child: Text(
              'No comments yet for post: $postId',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
            ),
          );
        }
        return Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
   Padding(
  padding: const EdgeInsets.all(5.0),
  child: Row(
    children: [
      Expanded(
        child: Center(
          child: Text(
            '${comments.length} Comments',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () => Navigator.of(context).pop(),
      ),
    ],
  ),
),

    Expanded(
      child: ListView.separated(
        itemCount: comments.length,
        itemBuilder: (context, index) {
          final comment = comments[index];
          return CommentCard(comment: comment);
        },
        separatorBuilder: (context, index) => const SizedBox(height: 12),
      ),
    ),
  ],
);
 },
       loading: () => const Center(
    child: LoadingWidget(message: 'Fetching Comments...'),
  ),
      error: (error, _) => Center(child: Text('Failed to load comments: $error')),
    );
  }
}
  


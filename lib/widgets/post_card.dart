// widgets/post_card.dart
import 'package:flutter/material.dart';
import '../models/post.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './components/comment_list.dart';
class PostCard extends ConsumerStatefulWidget {
   final Post post;
 

  
  PostCard({Key? key, required this.post}) : super(key: key);

  @override
  ConsumerState<PostCard> createState() => _PostCardState();
}

class _PostCardState extends ConsumerState<PostCard> {
  bool _isLiked = false;

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
    });
  }

@override
Widget build(BuildContext context) {
  final post = widget.post;

  // Watch the user provider for the current post's userId
  final userAsyncValue = ref.watch(userProvider(post.userId));

  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    elevation: 5,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Top: User info row (avatar + username)
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              userAsyncValue.when(
                data: (user) => CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: user.avatarUrl != null && user.avatarUrl!.isNotEmpty
                      ? NetworkImage(user.avatarUrl!)
                      : null,
                  child: (user.avatarUrl == null || user.avatarUrl!.isEmpty)
                      ? Text(
                          user.name.substring(0, 2),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        )
                      : null,
                ),
                loading: () => CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey[300],
                  child: const CircularProgressIndicator(strokeWidth: 2),
                ),
                error: (error, stack) => CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey[300],
                  child: const Icon(Icons.error, color: Colors.red),
                ),
              ),

              const SizedBox(width: 12),

              userAsyncValue.when(
                data: (user) => Text(
                  user.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF003366),
                  ),
                ),
                loading: () => const Text('Loading user...'),
                error: (error, stack) => const Text('Error loading user'),
              ),

              const Spacer(),

              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
                splashRadius: 20,
              ),
            ],
          ),
        ),

        // Divider
        const Divider(height: 1),

        // Post content (title + body)
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                post.body,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[800],
                ),
              ),
              
            ],
          ),
        ),

        // Divider
        const Divider(height: 1),

        // Bottom action bar (like, comment, share icons)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  _isLiked ? Icons.favorite : Icons.favorite_border,
                  color: _isLiked ? Colors.red : null,
                ),
                onPressed: _toggleLike,
                splashRadius: 20,
              ),
              IconButton(
               icon: const Icon(
                Icons.comment
                ),
  splashRadius: 20,
onPressed: () {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Important to allow custom height
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (BuildContext context) {
      return FractionallySizedBox(
        heightFactor: 0.6, // 50% of the screen height
        widthFactor: 1,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
          children: [
            

            // Your comment list or content
            Expanded(
              child: CommentList(postId: post.id!),
             

            ),
          ],
        ),
          
        ),
      );
    },
  );
},

),

              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {},
                splashRadius: 20,
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.bookmark_border),
                onPressed: () {},
                splashRadius: 20,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
}

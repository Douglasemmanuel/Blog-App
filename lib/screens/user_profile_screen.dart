import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/posts_provider.dart';
import '../models/post.dart';
import '../services/api_service.dart';
class UserScreen extends ConsumerStatefulWidget {
  const UserScreen({super.key});

  @override
  ConsumerState<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends ConsumerState<UserScreen> {
  @override
 
  @override
 Widget build(BuildContext context) {
  final post = ref.watch(createdPostProvider);
  
  return SafeArea(
    child: Scaffold(
      // You can uncomment the AppBar if needed
      // appBar: AppBar(
      //   title: const Text('User Profile'),
      //   centerTitle: true,
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/Douglas.jpeg'),
                    radius: 50,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Douglas Emmanuel',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'emmanueldouglas2121@gmail.com',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: const [
                  Icon(
                    Icons.photo_album,
                    size: 30,
                    color: Color(0xFF003366),
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),

            // Show PostCard only if post exists
            if (post != null) PostCard(post: post),
            if (post == null)
              const Text('No post created yet.'),
          ],
        ),
      ),
    ),
  );
}
}



class PostCard extends ConsumerWidget {
  // const PostCard({super.key});
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  final apiService = ref.read(apiServiceProvider);

  return Center(  // Optional: center horizontally
  child: SizedBox(
    width: 650,  // Set your desired width here
    child: Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(  // Use Column here to hold multiple children inside the Card
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Text(
                  post.title,
                  // 'Post Title',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF003366),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  post.body,
                  // 'This is a sample post body for display only.',
                  style: TextStyle(fontSize: 16),
                ),
                //  SizedBox(height: 8),
                // Text(
                //   post.userId.toString(),
                //   // 'This is a sample post body for display only.',
                //   style: TextStyle(fontSize: 16),
                // ),
              ],
            ),
          ),
          const Divider(height: 1),
                Row(
        children: [
          IconButton(
              icon: const Icon(Icons.edit),
              splashRadius: 20,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                        top: 16,
                        left: 16,
                        right: 16,
                      ),
                      child: EditFormSheet(
                        postId: post.id!,
                        userId: post.userId,
                         initialTitle: post.title,
                        initialBody: post.body,
                      ),
                    );
                  },
                );
              },
            ),

          // const Spacer(),
          IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                final bool? confirmed = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Confirm Delete'),
                    content: const Text('Are you sure you want to delete this item?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false), // Cancel
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true), // Confirm
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                );

                if (confirmed == true) {
                  try {
                      await apiService.deletePost(post.id!);
                      await ref.read(createdPostProvider.notifier).clearPost();
                      ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Post deleted successfully')),
                      );
                      // Optionally, notify parent widget to refresh list or remove this post from UI
                      } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to delete post: $e')),
                      );
                      }
                     print('Item deleted');
                }
              },
              splashRadius: 20,
            ),

        ],
      )

        ],
      ),
    ),
  ),
);


  }
}



//edit form input 
class EditFormSheet extends ConsumerStatefulWidget {
  final int postId;
  final int userId;
  final String initialTitle;
  final String initialBody;

  const EditFormSheet({
    Key? key,
    required this.postId,
    required this.userId,
    required this.initialTitle,
    required this.initialBody,
  }) : super(key: key);

  @override
  _EditFormSheetState createState() => _EditFormSheetState();
}

class _EditFormSheetState extends ConsumerState<EditFormSheet> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _bodyController;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(text: widget.initialTitle);
    _bodyController = TextEditingController(text: widget.initialBody);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  Future<void> _updatePost() async {
    if (!_formKey.currentState!.validate()) return;

    final title = _titleController.text;
    final body = _bodyController.text;

    final apiService = ref.read(apiServiceProvider);

    try {
      Post updatedPost = Post(
        id: widget.postId,
        userId: widget.userId,
        title: title,
        body: body,
      );

      final createdPost = await apiService.updatePost(updatedPost);
      await ref.read(createdPostProvider.notifier).setPost(createdPost);

      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update post: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Editing Post ${widget.postId} by User ${widget.userId}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  (value == null || value.isEmpty) ? 'Please enter value for Title' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _bodyController,
              decoration: const InputDecoration(
                labelText: 'Body',
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  (value == null || value.isEmpty) ? 'Please enter value for Body' : null,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updatePost,
              child: const Text('Save'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}


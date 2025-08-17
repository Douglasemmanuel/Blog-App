import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/post.dart';
import '../../services/api_service.dart'; // update the path as needed

class CreatePostForm extends ConsumerStatefulWidget {
  @override
  _CreatePostFormState createState() => _CreatePostFormState();
}

class _CreatePostFormState extends ConsumerState<CreatePostForm> {
  final _formKey = GlobalKey<FormState>();

  String title = '';
  String body = '';
  String userId = '';

  @override
  Widget build(BuildContext context) {
    final apiService = ref.read(apiServiceProvider); // <-- Access ApiService

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Container(
              margin: const EdgeInsets.only(top: 0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter title' : null,
                onSaved: (value) => title = value!,
              ),
            ),

            // User ID
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'User ID',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter userId';
                  if (int.tryParse(value) == null) return 'Enter a valid number';
                  return null;
                },
                onSaved: (value) => userId = value!,
              ),
            ),

            // Body
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Body',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
                // maxLines: 3,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter body' : null,
                onSaved: (value) => body = value!,
              ),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, 
                foregroundColor: Colors.white,
              ),
              child: const Text('Submit'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  final post = Post(
                    id: 0, 
                    title: title,
                    body: body,
                    userId: int.parse(userId),
                  );

                  try {
                    final createdPost = await apiService.createPost(post);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Post created with ID: ${createdPost.id}'),
                      ),
                    );

                    Navigator.of(context).pop(); // close bottom sheet
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to create post: $e')),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

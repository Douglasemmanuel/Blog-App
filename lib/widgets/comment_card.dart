import 'package:flutter/material.dart';
import '../../models/comment.dart';  // adjust import path as needed

class CommentCard extends StatelessWidget {
  final Comment comment;

  const CommentCard({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     String initials = comment.email.length >= 3
      ? comment.email.substring(0, 3)
      : comment.email; // fallback if email is shorter than 3 chars

    return Card(
  margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
  elevation: 0,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  child: Padding(
    padding: const EdgeInsets.all(12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Colors.blueGrey,
          child: Text(
            initials.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                comment.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(comment.body),
            ],
          ),
        ),
      ],
    ),
  ),
);

  }
}

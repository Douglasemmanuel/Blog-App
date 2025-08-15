import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User'),
        backgroundColor: Colors.deepPurple,
      ),
      body: const Center(
        child: Text(
          'User screen is empty for now.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

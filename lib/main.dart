import 'package:flutter/material.dart';
import '../../utils/route_generator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_service.dart';
import '../models/post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../providers/posts_provider.dart';
import '../preferences/post_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load saved Post from SharedPreferences
  final savedPost = await PostPreferences.loadPost();

  runApp(
    ProviderScope(
      // overrides: [
      //   createdPostProvider.overrideWith(() => CreatedPostNotifier(savedPost)),
      // ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: RouteGenerator.initial,
      onGenerateRoute: RouteGenerator.generateRoute,
      
    );
  }
}
// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   String _response = 'Loading...';

//   @override
//   void initState() {
//     super.initState();
//     _fetchPosts();
//   }

//   Future<void> _fetchPosts() async {
//     try {
//       final res = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
//       if (res.statusCode == 200) {
//         final List data = json.decode(res.body);
//         setState(() {
//           _response = 'Got ${data.length} posts';
//         });
//       } else {
//         setState(() {
//           _response = 'HTTP error: ${res.statusCode}';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _response = 'Exception: $e';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text('Test API')),
//         body: Center(child: Text(_response)),
//       ),
//     );
//   }
// }





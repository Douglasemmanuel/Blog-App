import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/post.dart';

class PostPreferences {
  static const _key = 'created_post';

  static Future<void> savePost(Post post) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(post.toJson());
    await prefs.setString(_key, jsonString);
  }

  static Future<Post?> loadPost() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString == null) return null;

    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    return Post.fromJson(jsonMap);
  }

  static Future<void> clearPost() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}

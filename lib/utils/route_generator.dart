
import 'package:flutter/material.dart';
import '../../screens/home_screen.dart';
import '../../screens/post_detail_screen.dart';
import '../../screens/user_profile_screen.dart';
import '../../screens/search_screen.dart';
import '../../widgets/commons/responsive_navigation.dart';

class RouteGenerator {
  static const String initial = '/';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String postdetail = '/post-detail';
  static const String search = '/search';


  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initial:
        return MaterialPageRoute(builder: (_) => ResponsiveNavigation());
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => UserScreen());
      case search:
          return MaterialPageRoute(builder:(_)=>SearchScreen());
      case postdetail:
        final postId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) =>  PostDetailScreen(postId: postId),
        );
      default:
        return _errorRoute();
    }
  }

  // This method is outside the generateRoute method — at class level!
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Page not found')),
      ),
    );
  }
}
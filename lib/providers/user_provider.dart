
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class UserNotifier extends AsyncNotifier<User> {
  @override
  Future<User> build(int userId) async {
    return ref.read(apiServiceProvider).fetchUser(userId);
  }
}

final userProvider = AsyncNotifierProvider.family<UserNotifier, User, int>((ref, userId) => UserNotifier()..build(userId));

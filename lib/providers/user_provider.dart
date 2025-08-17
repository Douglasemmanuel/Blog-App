
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../services/api_service.dart';

// class UserNotifier extends AsyncNotifier<User , int> {
//   @override
//   Future<User> build(int userId) async {
//     return ref.read(apiServiceProvider).fetchUser(userId);
//   }
// }
// final userProvider = AsyncNotifierProviderFamily<UserNotifier, User, int>(
//   () => UserNotifier(),
// );
// // final userProvider = AsyncNotifierProvider.family<UserNotifier, User, int>((ref, userId) => UserNotifier()..build(userId));


class UserNotifier extends FamilyAsyncNotifier<User, int> {
  @override
  Future<User> build(int userId) async {
    return ref.read(apiServiceProvider).fetchUser(userId);
  }
}

final userProvider = AsyncNotifierProviderFamily<UserNotifier, User, int>(
  () => UserNotifier(),
);
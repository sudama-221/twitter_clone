import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/repositories/auth_repository.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, User?>((ref) {
  return AuthController(ref)..appStarted();
});

class AuthController extends StateNotifier<User?> {
  final Ref _ref;
  StreamSubscription<User?>? _authStateChangesSubscription;

  AuthController(this._ref) : super(null) {
    _authStateChangesSubscription?.cancel();
    _authStateChangesSubscription = _ref
        .read(authRepositiryProvider)
        .authStateChanges
        .listen((user) => state = user);
  }

  @override
  void dispose() {
    _authStateChangesSubscription?.cancel();
    super.dispose();
  }

  void appStarted() async {
    final user = _ref.read(authRepositiryProvider).getCurrentUser();
    if (user == null) {
      // ログインしているユーザーがいなかったら匿名ログイン
      await _ref.read(authRepositiryProvider).signInAnonymously();
    }
  }

  void signOut() async {
    await _ref.read(authRepositiryProvider).signOut();
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/general_providers.dart';
import 'package:riverpod_app/repositories/custom_exception.dart';

abstract class BaseAuthRepository {
  Stream<User?> get authStateChanges;
  Future<void> signInAnonymously();
  User? getCurrentUser();
  Future<void> signOut();
}

final authRepositiryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref);
});

class AuthRepository implements BaseAuthRepository {
  final Ref _ref;
  const AuthRepository(this._ref);

  @override
  Stream<User?> get authStateChanges =>
      _ref.read(firebaseAuthProvider).authStateChanges();

  // 匿名ログイン
  @override
  Future<void> signInAnonymously() async {
    try {
      await _ref.read(firebaseAuthProvider).signInAnonymously();
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  User? getCurrentUser() {
    try {
      return _ref.read(firebaseAuthProvider).currentUser;
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _ref.read(firebaseAuthProvider).signOut();
      await signInAnonymously();
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}

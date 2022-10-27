import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twiiter_clone2/controller/base_auth_controller.dart';
import 'package:twiiter_clone2/model/user_state.dart';

final firebaseAuthProvider = Provider((ref) {
  return FirebaseAuth.instance;
});

abstract class BaseAuthRepository {
  Stream<User?> get authStateChanges;
  Future<UserState> feachUser(String uid);
  Future<void> signInWithEmail(String email, String password);
  Future<UserCredential> signUp(String email, String password);
  User? getCurrentUser();
  Future<void> signOut();
}

final authRepositoryProvider = Provider.autoDispose<AuthRepository>((ref) {
  return AuthRepository(ref);
});

class AuthRepository implements BaseAuthRepository {
  final Ref _ref;
  const AuthRepository(this._ref);

  @override
  Stream<User?> get authStateChanges =>
      _ref.read(firebaseAuthProvider).authStateChanges();

  // ログインしているユーザー情報
  @override
  Future<UserState> feachUser(String uid) async {
    final doc =
        _ref.read(firebaseFirestoreProvider).collection('users').doc(uid);
    final data = await doc.get();

    return UserState.fromDoc(data);
  }

  // ログイン
  @override
  Future<void> signInWithEmail(String email, String password) async {
    try {
      await _ref
          .read(firebaseAuthProvider)
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw convertAuthError(e.code);
    }
  }

  // 登録
  @override
  Future<UserCredential> signUp(String email, String password) async {
    try {
      final result = await _ref
          .read(firebaseAuthProvider)
          .createUserWithEmailAndPassword(email: email, password: password);
      return result;
    } on FirebaseAuthException catch (e) {
      throw convertAuthError(e.code);
    }
  }

  // ログインしているユーザー
  @override
  User? getCurrentUser() {
    try {
      return _ref.read(firebaseAuthProvider).currentUser;
    } on FirebaseAuthException catch (e) {
      throw convertAuthError(e.code);
    }
  }

  // ログアウト
  @override
  Future<void> signOut() async {
    try {
      await _ref.read(firebaseAuthProvider).signOut();
    } on FirebaseAuthException catch (e) {
      throw convertAuthError(e.code);
    }
  }
}

// エラー文を日本語にする
String convertAuthError(String errorCode) {
  switch (errorCode) {
    case 'invalid-email':
      return 'メールアドレスを正しい形式で入力してください';
    case 'wrong-password':
      return 'パスワードが間違っています';
    case 'user-not-found':
      return 'ユーザーが見つかりません';
    case 'weak-password':
      return 'パスワードは6文字以上で入力してください';
    case 'user-disabled':
      return 'ユーザーが無効です';
    case 'email-already-in-use':
      return 'このメールアドレスは既に登録されています';
    default:
      return '不明なエラーです';
  }
}

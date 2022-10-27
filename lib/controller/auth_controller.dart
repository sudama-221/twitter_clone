import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twiiter_clone2/model/user_state.dart';
import 'package:twiiter_clone2/repository/auth_repository.dart';

// 現在のログイン情報を監視
final authStateProvider = StreamProvider.autoDispose<User?>((ref) {
  return ref.read(authRepositoryProvider).authStateChanges;
});

// ログイン関係の処理
final currentUserProvider =
    StateNotifierProvider<currentUserControllerNotifier, User?>((ref) {
  return currentUserControllerNotifier(ref);
});

class currentUserControllerNotifier extends StateNotifier<User?> {
  final Ref _ref;
  currentUserControllerNotifier(this._ref) : super(null);

  User? get state => _ref.read(authRepositoryProvider).getCurrentUser();
}

// ログイン関係の処理
final authControllerProvider =
    StateNotifierProvider<AuthControllerNotifier, UserState?>((ref) {
  return AuthControllerNotifier(ref);
});

class AuthControllerNotifier extends StateNotifier<UserState?> {
  final Ref _ref;
  AuthControllerNotifier(this._ref) : super(null);

  // 新規登録
  Future<void> signUp(String name, String email, String password) async {
    try {
      final userCredential =
          await _ref.read(authRepositoryProvider).signUp(email, password);

      final user = userCredential.user;
      if (user != null) {
        final uid = user.uid;

        // firestoreに追加
        final doc = FirebaseFirestore.instance.collection('users').doc(uid);
        await doc.set({
          'uid': uid,
          'email': email,
          'name': name,
          'discription': '',
          'coverImageUrl': '',
          'profileImageUrl': '',
        });
      }
    } catch (e) {
      throw e.toString();
    }
  }

  // ログイン
  Future<void> signIn(String email, String password) async {
    try {
      await _ref.read(authRepositoryProvider).signInWithEmail(email, password);
    } catch (e) {
      throw e.toString();
    }
  }

  void siginOut() async {
    await _ref.read(authRepositoryProvider).signOut();
  }
}

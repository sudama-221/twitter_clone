import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone2/model/user_state.dart';
import 'package:twitter_clone2/repository/auth_repository.dart';

// 現在のログイン情報を監視
final authStateProvider = StreamProvider<User?>((ref) {
  return ref.read(authRepositoryProvider).authStateChanges;
});

// ログイン状況の把握とログインしていればそのユーザーのIDを取得　stringでIDを返す
// ログイン情報が変化するとこの中も再描画
final currentUserProvider = Provider<String?>((ref) {
  final auth = ref.watch(authStateProvider);
  if (auth.asData?.value?.uid != null) {
    return auth.asData?.value?.uid;
  } else {
    return null;
  }
});

// ↑で再描画されたのを通知されてユーザーのデータを取得する
final userStateProvider = FutureProvider<UserState?>((ref) async {
  final userId = ref.watch(currentUserProvider);
  if (userId != null) {
    var userData = await ref.read(authRepositoryProvider).feachUser(userId);
    return userData;
  } else {
    return null;
  }
});

// ログイン関係の処理
final authControllerProvider =
    StateNotifierProvider<AuthControllerNotifier, UserState?>((ref) {
  return AuthControllerNotifier(ref.read);
});

class AuthControllerNotifier extends StateNotifier<UserState?> {
  final Reader _read;
  AuthControllerNotifier(this._read) : super(null);

  Future<void> signUp(String name, String email, String password) async {
    try {
      final userCredential =
          await _read(authRepositoryProvider).signUp(email, password);

      final user = userCredential.user;
      if (user != null) {
        final uid = user.uid;

        // firestoreに追加
        final doc = FirebaseFirestore.instance.collection('users').doc(uid);
        await doc.set(
            {'uid': uid, 'email': email, 'name': name, 'discription': null});
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _read(authRepositoryProvider).signInWithEmail(email, password);
    } catch (e) {
      throw e.toString();
    }
  }

  void siginOut() async {
    await _read(authRepositoryProvider).signOut();
  }
}

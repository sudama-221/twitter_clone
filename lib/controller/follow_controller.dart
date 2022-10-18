import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone2/controller/base_auth_controller.dart';
import 'package:twitter_clone2/repository/user_repository.dart';

// 現在のフォローしている人情報を監視
final followingStateProvider =
    StreamProvider.autoDispose.family<QuerySnapshot, String>((ref, uid) {
  print('stream: $uid');
  return ref.read(followingRef).doc(uid).collection('Following').snapshots();
});

// 現在のフォロワー情報を監視
final followerStateProvider =
    StreamProvider.autoDispose.family<QuerySnapshot, String>((ref, uid) {
  return ref.read(followerRef).doc(uid).collection('Followers').snapshots();
});

// フォロー関係の処理
final followControllerProvider =
    StateNotifierProvider<FollowControllerNotifier, bool>((ref) {
  return FollowControllerNotifier(ref.read);
});

class FollowControllerNotifier extends StateNotifier<bool> {
  final Reader _read;
  FollowControllerNotifier(this._read) : super(false);

  // フォローする
  Future<void> followUser(String currentUserId, String visitedUserId) async {
    try {
      await _read(userRepositoryProvider)
          .followUser(currentUserId, visitedUserId);
      state = true;
    } catch (e) {
      throw e.toString();
    }
  }

  // フォロー外す
  Future<void> unFollowUser(String currentUserId, String visitedUserId) async {
    try {
      await _read(userRepositoryProvider)
          .unFollowUser(currentUserId, visitedUserId);
      state = false;
    } catch (e) {
      throw e.toString();
    }
  }

  // currentUserがvisitedUserをフォローしているか
  Future<bool> isFollowingUser(
      String currentUserId, String visitedUserId) async {
    state = await _read(userRepositoryProvider)
        .isFollowingUser(currentUserId, visitedUserId);
    return state;
  }
}

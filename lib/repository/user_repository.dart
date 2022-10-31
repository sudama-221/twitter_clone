import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twiiter_clone2/controller/base_auth_controller.dart';

abstract class BaseUserRepository {
  Future<void> followUser(String currentUserId, String visitedUserId);
  Future<void> unFollowUser(String currentUserId, String visitedUserId);
  Future<QuerySnapshot> searchUser(String name);
  Future<bool> isFollowingUser(String currentUserId, String visitedUserId);
}

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(ref);
});

class UserRepository implements BaseUserRepository {
  final Ref _ref;
  UserRepository(this._ref);

  // フォローする
  @override
  Future<void> followUser(String currentUserId, String visitedUserId) async {
    await _ref
        .read(followingRef)
        .doc(currentUserId)
        .collection('Following')
        .doc(visitedUserId)
        .set({});

    await _ref
        .read(followerRef)
        .doc(visitedUserId)
        .collection('Followers')
        .doc(currentUserId)
        .set({});
  }

  // フォロー外す
  @override
  Future<void> unFollowUser(String currentUserId, String visitedUserId) async {
    await _ref
        .read(followingRef)
        .doc(currentUserId)
        .collection('Following')
        .doc(visitedUserId)
        .get()
        .then(
      (doc) {
        if (doc.exists) {
          doc.reference.delete();
        }
      },
    );

    await _ref
        .read(followerRef)
        .doc(visitedUserId)
        .collection('Followers')
        .doc(currentUserId)
        .get()
        .then(
      (doc) {
        if (doc.exists) {
          doc.reference.delete();
        }
      },
    );
  }

  @override
  Future<QuerySnapshot> searchUser(String name) async {
    QuerySnapshot users = await _ref
        .read(userRef)
        .where('name', isGreaterThanOrEqualTo: name)
        .where('name', isLessThan: '${name}z')
        .get();
    return users;
  }

  // ログインユーザーが訪れたユーザーをフォローしているか
  @override
  Future<bool> isFollowingUser(
      String currentUserId, String visitedUserId) async {
    DocumentSnapshot followingDoc = await _ref
        .read(followerRef)
        .doc(visitedUserId)
        .collection('Followers')
        .doc(currentUserId)
        .get();
    return followingDoc.exists;
  }
}

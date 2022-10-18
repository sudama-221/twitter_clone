import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone2/controller/base_auth_controller.dart';

abstract class BaseUserRepository {
  Future<void> followUser(String currentUserId, String visitedUserId);
  Future<void> unFollowUser(String currentUserId, String visitedUserId);
  Future<QuerySnapshot> searchUser(String name);
  Future<bool> isFollowingUser(String currentUserId, String visitedUserId);
}

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(ref.read);
});

class UserRepository implements BaseUserRepository {
  final Reader _read;
  const UserRepository(this._read);

  // フォローする
  @override
  Future<void> followUser(String currentUserId, String visitedUserId) async {
    await _read(followingRef)
        .doc(currentUserId)
        .collection('Following')
        .doc(visitedUserId)
        .set({});

    await _read(followerRef)
        .doc(visitedUserId)
        .collection('Followers')
        .doc(currentUserId)
        .set({});
  }

  // フォロー外す
  @override
  Future<void> unFollowUser(String currentUserId, String visitedUserId) async {
    await _read(followingRef)
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

    await _read(followerRef)
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
    QuerySnapshot users = await _read(userRef)
        .where('name', isGreaterThanOrEqualTo: name)
        .where('name', isLessThan: '${name}z')
        .get();
    return users;
  }

  // ログインユーザーが訪れたユーザーをフォローしているか
  @override
  Future<bool> isFollowingUser(
      String currentUserId, String visitedUserId) async {
    DocumentSnapshot followingDoc = await _read(followerRef)
        .doc(visitedUserId)
        .collection('Followers')
        .doc(currentUserId)
        .get();
    return followingDoc.exists;
  }
}

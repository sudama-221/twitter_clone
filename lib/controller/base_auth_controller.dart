import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final firebaseStorageProvider = Provider<FirebaseStorage>((ref) {
  return FirebaseStorage.instance;
});

final userRef = Provider<CollectionReference>((ref) {
  return ref.watch(firebaseFirestoreProvider).collection(('users'));
});
final followerRef = Provider<CollectionReference>((ref) {
  return ref.watch(firebaseFirestoreProvider).collection(('followers'));
});
final followingRef = Provider<CollectionReference>((ref) {
  return ref.watch(firebaseFirestoreProvider).collection(('following'));
});
final tweetRef = Provider<CollectionReference>((ref) {
  return ref.watch(firebaseFirestoreProvider).collection(('tweets'));
});
// ユーザーがいいねしたツイート
final userLikesRef = Provider<CollectionReference>((ref) {
  return ref.watch(firebaseFirestoreProvider).collection(('userLikeTweets'));
});
// ツイートに紐づくいいねしたユーザー
final tweetLikesUsersRef = Provider<CollectionReference>((ref) {
  return ref.watch(firebaseFirestoreProvider).collection(('tweetLikeUsers'));
});

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twiiter_clone2/controller/base_auth_controller.dart';

abstract class BaseLikeRepository {
  Future<void> likeTweet(String tweetId, String currentUserId);
  Future<void> unLikeTweet(String tweetId, String currentUserId);
  Future<bool> isLikedTweet(String tweetId, String currentUserId);
}

final likesRepositoryProvider = Provider.autoDispose<LikeRepository>((ref) {
  return LikeRepository(ref);
});

class LikeRepository implements BaseLikeRepository {
  final Ref _ref;
  const LikeRepository(this._ref);

  // いいねする
  @override
  Future<void> likeTweet(String tweetId, String currentUserId) async {
    // いいねしたツイートにいいね数を1足す
    final tweetDoc = _ref.read(tweetRef).doc(tweetId);
    await tweetDoc.update({'likes': FieldValue.increment(1)});
    // ツイートに紐づくいいねしたユーザーを追加
    await _ref
        .read(tweetLikesUsersRef)
        .doc(tweetId)
        .collection('users')
        .doc(currentUserId)
        .set({});

    // ユーザーにいいねしたツイートを追加
    await _ref
        .read(userLikesRef)
        .doc(currentUserId)
        .collection('tweet')
        .doc(tweetId)
        .set({});
  }

  // いいねを外す
  @override
  Future<void> unLikeTweet(String tweetId, String currentUserId) async {
    // いいねしたツイートにいいね数を１引く
    final tweetDoc = _ref.read(tweetRef).doc(tweetId);
    await tweetDoc.update({'likes': FieldValue.increment(-1)});

    // ツイートに紐づくいいねしたユーザーを追加
    await _ref
        .read(tweetLikesUsersRef)
        .doc(tweetId)
        .collection('users')
        .doc(currentUserId)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });

    // ユーザーにいいねしたツイートを追加
    await _ref
        .read(userLikesRef)
        .doc(currentUserId)
        .collection('tweet')
        .doc(tweetId)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
  }

  // いいねしているかチェック
  @override
  Future<bool> isLikedTweet(String tweetId, String currentUserId) async {
    DocumentSnapshot likedDoc = await _ref
        .read(tweetLikesUsersRef)
        .doc(tweetId)
        .collection('users')
        .doc(currentUserId)
        .get();
    print('repo: ${likedDoc.exists}');
    return likedDoc.exists;
  }
}

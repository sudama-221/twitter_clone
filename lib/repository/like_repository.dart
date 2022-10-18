import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone2/controller/base_auth_controller.dart';
import 'package:twitter_clone2/model/tweet_state.dart';
import 'package:twitter_clone2/model/user_state.dart';

abstract class BaseLikeRepository {
  Future<void> likeTweet(TweetState tweetState, UserState userState);
  Future<void> unLikeTweet(TweetState tweetState, UserState userState);
  Future<bool> isLikedTweet(TweetState tweetState, String userId);
}

final likesRepositoryProvider = Provider.autoDispose<LikeRepository>((ref) {
  return LikeRepository(ref.read);
});

class LikeRepository implements BaseLikeRepository {
  final Reader _read;
  const LikeRepository(this._read);

  // いいねする
  @override
  Future<void> likeTweet(TweetState tweetState, UserState userState) async {
    // いいねしたツイートにいいね数を1足す
    print('repo:${tweetState.likes!}');
    final tweetDoc = _read(tweetRef).doc(tweetState.id);
    tweetDoc.update({'likes': FieldValue.increment(1)});

    // ツイートに紐づくいいねしたユーザーを追加
    await _read(tweetLikesUsersRef)
        .doc(tweetState.id)
        .collection('users')
        .doc(userState.uid)
        .set({});

    // ユーザーにいいねしたツイートを追加
    await _read(userLikesRef)
        .doc(userState.uid)
        .collection('tweet')
        .doc(tweetState.id)
        .set({});
  }

  // いいねを外す
  @override
  Future<void> unLikeTweet(TweetState tweetState, UserState userState) async {
    // いいねしたツイートにいいね数を1足す
    await _read(tweetRef)
        .doc(tweetState.id)
        .update({'likes': tweetState.likes! - 1});

    // ツイートに紐づくいいねしたユーザーを追加
    await _read(tweetLikesUsersRef)
        .doc(tweetState.id)
        .collection('users')
        .doc(userState.uid)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });

    // ユーザーにいいねしたツイートを追加
    await _read(userLikesRef)
        .doc(userState.uid)
        .collection('tweet')
        .doc(tweetState.id)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
  }

  // いいねしているかチェック
  @override
  Future<bool> isLikedTweet(TweetState tweetState, String userId) async {
    DocumentSnapshot likedDoc = await _read(tweetLikesUsersRef)
        .doc(tweetState.id)
        .collection('users')
        .doc(userId)
        .get();
    return likedDoc.exists;
  }
}

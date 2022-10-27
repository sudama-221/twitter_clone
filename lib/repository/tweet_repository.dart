import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twiiter_clone2/controller/base_auth_controller.dart';
import 'package:twiiter_clone2/model/tweet_state.dart';
import 'package:uuid/uuid.dart';

abstract class BaseTweetRepository {
  Future<void> tweetImgUpload(File imgFile);
  Future<void> createTweet(TweetState tweetState);
  Future<List<TweetState>> getUserTweets(String userId);
  Future<List<TweetState>> followingUserTweets(String currentUid);
}

final tweetRepositoryProvider = Provider.autoDispose<TweetRepository>((ref) {
  return TweetRepository(ref);
});

class TweetRepository implements BaseTweetRepository {
  final Ref _ref;
  const TweetRepository(this._ref);

  // ツイートにある画像をfirestorageへ
  @override
  Future<String> tweetImgUpload(File imgFile) async {
    String uniquePhotoId = const Uuid().v4();
    String imgUrl = '';

    final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': imgFile.path});
    UploadTask uploadTask;
    Reference ref = _ref
        .read(firebaseStorageProvider)
        .ref()
        .child('tweets')
        .child('/tweet$uniquePhotoId.jpg');

    // firestorageにアップロード
    try {
      uploadTask = ref.putData(await imgFile.readAsBytes(), metadata);
      imgUrl = await (await uploadTask).ref.getDownloadURL();
    } catch (e) {
      print(e.toString());
    }
    return imgUrl;
  }

  // ツイート作成
  @override
  Future<void> createTweet(TweetState tweetState) async {
    DocumentReference doc = _ref.read(tweetRef).doc();
    await doc.set({
      'text': tweetState.text,
      'image': tweetState.imageUrl,
      'authorId': tweetState.authorId,
      'timestamp': tweetState.timestamp,
      'likes': tweetState.likes,
      'retweets': tweetState.retweets,
    });
  }

  // ユーザーを指定してツイートを取得
  @override
  Future<List<TweetState>> getUserTweets(String userId) async {
    QuerySnapshot snapshot = await _ref
        .read(tweetRef)
        .where('authorId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .get();

    List<TweetState> userTweet =
        snapshot.docs.map((doc) => TweetState.fromDoc(doc)).toList();
    return userTweet;
  }

  // フォローしているユーザーのツイートを取得
  // followingユーザーのツイートを何日まで取得して日付順にソートする
  @override
  Future<List<TweetState>> followingUserTweets(String currentUid) async {
    List<TweetState> followingUserTweetList = <TweetState>[]; // ツイートを格納

    getTweet(String uid) async {
      QuerySnapshot userTweetsSnap = await _ref
          .read(tweetRef)
          .where('authorId', isEqualTo: uid)
          .orderBy('timestamp', descending: true)
          .get();
      List<TweetState> userTweets =
          userTweetsSnap.docs.map((doc) => TweetState.fromDoc(doc)).toList();
      // ツイートを追加していく
      followingUserTweetList.addAll(userTweets);
    }

    QuerySnapshot followingUserSnap = await _ref
        .read(followingRef)
        .doc(currentUid)
        .collection('Following')
        .get();

    // フォローしているユーザーのIDをリスト化
    List<String> followingUserId =
        followingUserSnap.docs.map((doc) => doc.id).toList();
    await getTweet(currentUid);
    // 上のリストでその人のツイートを取得
    for (String uid in followingUserId) {
      await getTweet(uid);
    }

    // 全てのツイートを日時順で表示する（降順）
    followingUserTweetList
        .sort(((a, b) => b.createdAt!.compareTo(a.createdAt!)));
    return followingUserTweetList;
  }
}

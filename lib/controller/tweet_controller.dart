import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twiiter_clone2/model/tweet_state.dart';
import 'package:twiiter_clone2/repository/tweet_repository.dart';

// プロフィールページのツイート取得　useridで取得する
final userTweetListProvider = FutureProvider.autoDispose
    .family<List<TweetState>, String>((ref, uid) async {
  if (uid != 'null') {
    List<TweetState> _allTweet =
        await ref.read(tweetRepositoryProvider).getUserTweets(uid);
    return _allTweet;
  } else {
    return [];
  }
});

// ↑の画像があるものだけ
final userImageTweetListProvider = FutureProvider.autoDispose
    .family<List<TweetState>, String>((ref, uid) async {
  if (uid != 'null') {
    List<TweetState> _allTweet =
        await ref.read(tweetRepositoryProvider).getUserTweets(uid);
    List<TweetState> _mediaTweet =
        _allTweet.where((element) => element.imageUrl!.isNotEmpty).toList();
    return _mediaTweet;
  } else {
    return [];
  }
});

// フォローしているユーザー全員のツイート
final followingTweetListProvider = FutureProvider.autoDispose
    .family<List<TweetState>, String>((ref, uid) async {
  if (uid != 'null') {
    List<TweetState> _followingUsertweet =
        await ref.read(tweetRepositoryProvider).followingUserTweets(uid);
    return _followingUsertweet;
  } else {
    return [];
  }
});

final tweetProvider =
    StateNotifierProvider<tweetNotifier, List<TweetState>?>((ref) {
  return tweetNotifier(ref.read);
});

class tweetNotifier extends StateNotifier<List<TweetState>?> {
  final _read;
  tweetNotifier(this._read) : super(null);

  Future<String> tweetImgUpload(File imgFile) async {
    String imgUrl;
    try {
      imgUrl = await _read(tweetRepositoryProvider).tweetImgUpload(imgFile);
    } catch (_) {
      imgUrl = '';
    }
    return imgUrl;
  }

  Future<void> createTweet(TweetState tweetState) async {
    try {
      await _read(tweetRepositoryProvider).createTweet(tweetState);
    } catch (_) {
      throw 'ツイートできませんでした';
    }
  }
}

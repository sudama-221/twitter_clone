// 自分がいいねしているか確認
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone2/controller/base_auth_controller.dart';
import 'package:twitter_clone2/model/likes_state.dart';
import 'package:twitter_clone2/model/tweet_state.dart';
import 'package:twitter_clone2/model/user_state.dart';
import 'package:twitter_clone2/repository/like_repository.dart';

// いいねを監視
final likeCheckProvider = StreamProvider.autoDispose
    .family<DocumentSnapshot, LikesState>((ref, likeState) {
  return ref
      .read(tweetLikesUsersRef)
      .doc(likeState.tweet!.id)
      .collection('users')
      .doc(likeState.userId)
      .snapshots();
});

final likeProvider =
    StateNotifierProvider.autoDispose<likeCheckNotifier, int?>((ref) {
  return likeCheckNotifier(ref.read);
});

class likeCheckNotifier extends StateNotifier<int?> {
  final Reader _read;
  likeCheckNotifier(this._read) : super(null);

  // いいねする
  Future<void> likeTweet(TweetState tweetState, UserState userState) async {
    print(tweetState.likes);
    try {
      _read(likesRepositoryProvider).likeTweet(tweetState, userState);
      state = tweetState.likes! + 1;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> unLikeTweet(TweetState tweetState, UserState userState) async {
    print(tweetState.likes);
    try {
      _read(likesRepositoryProvider).unLikeTweet(tweetState, userState);
      state = tweetState.likes! - 1;
    } catch (e) {
      print(e.toString());
    }
  }
}

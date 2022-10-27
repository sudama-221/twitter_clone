// 自分がいいねしているか確認
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twiiter_clone2/controller/base_auth_controller.dart';
import 'package:twiiter_clone2/model/likes_state.dart';
import 'package:twiiter_clone2/model/tweet_state.dart';
import 'package:twiiter_clone2/repository/like_repository.dart';

// いいねを監視
// final likeCheckProvider = StreamProvider.autoDispose
//     .family<DocumentSnapshot, LikesState>((ref, likeState) {
//   return ref
//       .read(tweetLikesUsersRef)
//       .doc(likeState.tweetId)
//       .collection('users')
//       .doc(likeState.userId)
//       .snapshots();
// });

final likeCheckProvider =
    FutureProvider.family<bool, LikesState>((ref, likesState) async {
  String tweetId = likesState.tweetId!;
  String currentUserId = likesState.userId!;
  return await ref
      .read(likesRepositoryProvider)
      .isLikedTweet(tweetId, currentUserId);
});

final likeProvider =
    StateNotifierProvider.autoDispose<likeCheckNotifier, TweetState>((ref) {
  return likeCheckNotifier(ref);
});

class likeCheckNotifier extends StateNotifier<TweetState> {
  final Ref _ref;
  likeCheckNotifier(this._ref) : super(const TweetState(isLiked: false));

  // いいねを確認する
  Future<bool> isLikedCheck(LikesState likesState) async {
    String tweetId = likesState.tweetId!;
    String currentUserId = likesState.userId!;
    try {
      bool _isLiked = await _ref
          .read(likesRepositoryProvider)
          .isLikedTweet(tweetId, currentUserId);
      state = state.copyWith(isLiked: _isLiked);
      return _isLiked;
    } catch (e) {
      print(e.toString());
      state = state;
      return false;
    }
  }

  // いいねする
  Future<void> likeTweet(LikesState likesState) async {
    String tweetId = likesState.tweetId!;
    String currentUserId = likesState.userId!;
    try {
      _ref.read(likesRepositoryProvider).likeTweet(tweetId, currentUserId);
      state = state.copyWith(isLiked: true);
    } catch (e) {
      print(e.toString());
      state = state;
    }
  }

  // いいねを外す
  Future<void> unLikeTweet(LikesState likesState) async {
    String tweetId = likesState.tweetId!;
    String currentUserId = likesState.userId!;
    try {
      _ref.read(likesRepositoryProvider).unLikeTweet(tweetId, currentUserId);
      state = state.copyWith(isLiked: false);
    } catch (e) {
      print(e.toString());
    }
    state = state;
  }
}

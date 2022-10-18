import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone2/controller/like_controller.dart';
import 'package:twitter_clone2/model/likes_state.dart';
import 'package:twitter_clone2/model/tweet_state.dart';
import 'package:twitter_clone2/model/user_state.dart';

// class LikeButton extends ConsumerStatefulWidget {
//   const LikeButton({
//     Key? key,
//     required this.tweetState,
//     required this.author,
//     required this.currentUserId,
//   }) : super(key: key);

//   final TweetState tweetState;
//   final UserState author;
//   final String currentUserId;

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _LikeButtonState();
// }

// class _LikeButtonState extends ConsumerState<LikeButton> {

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

class LikeButton extends ConsumerWidget {
  const LikeButton({
    Key? key,
    required this.tweetState,
    required this.author,
    required this.currentUserId,
  }) : super(key: key);

  final TweetState tweetState;
  final UserState author;
  final String currentUserId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    LikesState _likesState =
        LikesState(userId: currentUserId, tweet: tweetState);

    final AsyncValue<DocumentSnapshot> _isLikedSnap =
        ref.watch(likeCheckProvider(_likesState));
    return _isLikedSnap.when(data: (DocumentSnapshot snapshot) {
      return Row(
        children: [
          IconButton(
              onPressed: () {
                snapshot.exists
                    ? ref
                        .read(likeProvider.notifier)
                        .unLikeTweet(tweetState, author)
                    : ref
                        .read(likeProvider.notifier)
                        .likeTweet(tweetState, author);
              },
              icon: Icon(
                snapshot.exists ? Icons.favorite : Icons.favorite_border,
                size: 18,
                color: Colors.pink[400],
              )),
          Text(tweetState.likes.toString()),
        ],
      );
    }, error: ((error, stackTrace) {
      return Center(
        child: Text(error.toString()),
      );
    }), loading: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}

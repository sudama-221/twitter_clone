import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twiiter_clone2/controller/like_controller.dart';
import 'package:twiiter_clone2/model/likes_state.dart';
import 'package:twiiter_clone2/model/tweet_state.dart';
import 'package:twiiter_clone2/model/user_state.dart';

class LikeButton extends ConsumerStatefulWidget {
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
  ConsumerState<ConsumerStatefulWidget> createState() => _LikeButtonState();
}

class _LikeButtonState extends ConsumerState<LikeButton> {
  late final LikesState _likesState =
      LikesState(userId: widget.currentUserId, tweetId: widget.tweetState.id);

  bool _isLiked = false;
  int _likeCount = 0;

  setIsLiked() async {
    _isLiked = await ref.read(likeProvider.notifier).isLikedCheck(_likesState);
    _likeCount = widget.tweetState.likes!;
  }

  pushLike() {
    if (_isLiked) {
      ref.read(likeProvider.notifier).unLikeTweet(_likesState);
      setState(() {
        _isLiked = false;
        _likeCount--;
      });
    } else {
      ref.read(likeProvider.notifier).likeTweet(_likesState);
      setState(() {
        _isLiked = true;
        _likeCount++;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setIsLiked();
  }

  @override
  Widget build(BuildContext context) {
    final likeWatch = ref.watch(likeProvider);
    return Row(
      children: [
        IconButton(
            onPressed: () {
              pushLike();
            },
            icon: Icon(
              _isLiked ? Icons.favorite : Icons.favorite_border,
              size: 18,
              color: Colors.pink[400],
            )),
        Text(_likeCount.toString()),
      ],
    );
  }
}

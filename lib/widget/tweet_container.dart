import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone2/controller/user_controller.dart';
import 'package:twitter_clone2/model/tweet_state.dart';
import 'package:twitter_clone2/model/user_state.dart';
import 'package:twitter_clone2/util/color.dart';
import 'package:twitter_clone2/widget/tweet/like_btn.dart';

class TweetContainer extends ConsumerWidget {
  final TweetState tweetState;
  final String currentUserId;
  const TweetContainer(
      {super.key, required this.tweetState, required this.currentUserId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserState? author =
        ref.watch(userStateProvider(tweetState.authorId!)).value;
    print('いいね ${tweetState.likes}');
    if (author != null) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: author.profileImageUrl!.isEmpty
                      ? const AssetImage('assets/img/placeholder.png')
                          as ImageProvider
                      : NetworkImage(author.profileImageUrl!),
                ),
                const SizedBox(width: 10),
                Text(
                  author.name!,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              tweetState.text!,
              style: const TextStyle(fontSize: 15),
            ),
            tweetState.imageUrl!.isEmpty
                ? const SizedBox.shrink()
                : Column(
                    children: [
                      const SizedBox(height: 15),
                      Container(
                        height: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: mainColor,
                            image: DecorationImage(
                                image: NetworkImage(tweetState.imageUrl!),
                                fit: BoxFit.cover)),
                      )
                    ],
                  ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        LikeButton(
                          tweetState: tweetState,
                          author: author,
                          currentUserId: currentUserId,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(onPressed: () {}, icon: Icon(Icons.repeat)),
                        // const SizedBox(width: 5),
                        Text(tweetState.retweets.toString()),
                      ],
                    ),
                  ],
                ),
                Text(
                  tweetState.timestamp!.toDate().toString().substring(0, 19),
                  style: const TextStyle(color: Colors.grey),
                )
              ],
            ),
            const SizedBox(height: 10),
            const Divider()
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }
}

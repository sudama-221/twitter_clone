import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone2/controller/tweet_controller.dart';
import 'package:twitter_clone2/controller/user_controller.dart';
import 'package:twitter_clone2/widget/tweet_container.dart';

class TimelinePage extends StatelessWidget {
  final String currentUserId;
  const TimelinePage({super.key, required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: (() {
              // 画面遷移
            }),
            icon: Consumer(
              builder: (context, ref, child) {
                final currentUser =
                    ref.watch(userStateProvider(currentUserId)).value;
                return CircleAvatar(
                  radius: 45,
                  backgroundImage: currentUser == null
                      ? const AssetImage('assets/img/placeholder.png')
                      : currentUser.profileImageUrl!.isEmpty
                          ? const AssetImage('assets/img/placeholder.png')
                              as ImageProvider
                          : NetworkImage(currentUser.profileImageUrl!),
                );
              },
            ),
          ),
          title: SizedBox(
            height: 20,
            child: Image.asset('assets/img/logo.png'),
          ),
          actions: [
            IconButton(
              onPressed: (() {}),
              icon: const Icon(Icons.exit_to_app),
            ),
          ],
        ),
        body: Consumer(builder: (context, ref, child) {
          final _allTweet =
              ref.watch(followingTweetListProvider(currentUserId));
          return RefreshIndicator(
              onRefresh: (() async {
                ref.refresh(followingTweetListProvider(currentUserId));
              }),
              child: _allTweet.when(data: (tweet) {
                if (tweet.isNotEmpty) {
                  return ListView.builder(
                      itemCount: tweet.length,
                      itemBuilder: (context, index) {
                        print(tweet[index].likes);
                        return TweetContainer(
                          tweetState: tweet[index],
                          currentUserId: currentUserId,
                        );
                      });
                }
                return const Center(
                  child: Text('ツイートがありません'),
                );
              }, error: (e, _) {
                return const Center(
                  child: Text('データの取得に失敗しました'),
                );
              }, loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }));
        }));
  }
}

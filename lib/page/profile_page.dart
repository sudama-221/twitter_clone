import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone2/controller/auth_controller.dart';
import 'package:twitter_clone2/controller/follow_controller.dart';
import 'package:twitter_clone2/controller/tweet_controller.dart';
import 'package:twitter_clone2/controller/user_controller.dart';
import 'package:twitter_clone2/model/tweet_state.dart';
import 'package:twitter_clone2/model/user_state.dart';
import 'package:twitter_clone2/page/auth_check.dart';
import 'package:twitter_clone2/page/edit_profile_page.dart';
import 'package:twitter_clone2/util/color.dart';
import 'package:twitter_clone2/widget/follow_btn.dart';
import 'package:twitter_clone2/widget/follow_text.dart';
import 'package:twitter_clone2/widget/tweet_container.dart';

class ProfilePage extends ConsumerWidget {
  final String uid;
  final String currentUid;
  const ProfilePage({super.key, required this.uid, required this.currentUid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValueuserState = ref.watch(userStateProvider(uid));

    return asyncValueuserState.when(data: (user) {
      return (user != null)
          ? profileWidget(
              uid: uid,
              currentUid: currentUid,
              user: user,
            )
          : const Center(
              child: Text('ログインしていない'),
            );
    }, error: (e, _) {
      return const Center(
        child: Text('データの取得に失敗しました'),
      );
    }, loading: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}

class profileWidget extends ConsumerStatefulWidget {
  profileWidget({
    Key? key,
    required this.uid,
    required this.currentUid,
    required this.user,
  }) : super(key: key);

  final String uid;
  final String currentUid;
  UserState user;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _profileWidgetState();
}

class _profileWidgetState extends ConsumerState<profileWidget> {
  int _profileSegmentedValue = 0;
  bool isFollow = false;

  final Map<int, Widget> _profileTabs = <int, Widget>{
    0: const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        'ツイート',
        style: TextStyle(
            fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white),
      ),
    ),
    1: const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        '画像',
        style: TextStyle(
            fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white),
      ),
    ),
    2: const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        'いいね',
        style: TextStyle(
            fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white),
      ),
    ),
  };

  Widget buildProfileWidgets(UserState author) {
    switch (_profileSegmentedValue) {
      case 0:
        return Consumer(builder: (context, ref, child) {
          final _allTweet = ref.watch(userTweetListProvider(widget.uid));

          return _allTweet.when(data: (tweet) {
            return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tweet.length,
                itemBuilder: (context, index) {
                  return TweetContainer(
                    tweetState: tweet[index],
                    currentUserId: widget.currentUid,
                  );
                });
          }, error: (e, _) {
            return const Center(
              child: Text('データの取得に失敗しました'),
            );
          }, loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
        });
      case 1:
        return Consumer(builder: (context, ref, child) {
          final _mediaTweet = ref.watch(userImageTweetListProvider(widget.uid));

          return _mediaTweet.when(data: (tweet) {
            return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tweet.length,
                itemBuilder: (context, index) {
                  return TweetContainer(
                    tweetState: tweet[index],
                    currentUserId: widget.currentUid,
                  );
                });
          }, error: (e, _) {
            return const Center(
              child: Text('データの取得に失敗しました'),
            );
          }, loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
        });
      case 2:
        return const Center(
          child: Text(
            'いいね',
            style: TextStyle(fontSize: 25),
          ),
        );
      default:
        return const Center(
          child: Text(
            'なし',
            style: TextStyle(fontSize: 25),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    isFollow = ref.watch(followControllerProvider);
    return Scaffold(
      body: RefreshIndicator(
        // 下スクロールで更新
        // onRefresh: () async => await ref.refresh(userStateProvider(widget.uid)),
        onRefresh: () async {
          ref.refresh(userStateProvider(widget.uid));
          ref.refresh(userTweetListProvider(widget.uid));
        },
        child: ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                  color: mainColor,
                  image: widget.user.coverImageUrl!.isEmpty
                      ? null
                      : DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.user.coverImageUrl!))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox.shrink(),
                    widget.uid == widget.currentUid
                        ? PopupMenuButton(
                            icon: const Icon(
                              Icons.more_horiz,
                              color: Colors.white,
                              size: 30,
                            ),
                            itemBuilder: (_) {
                              return <PopupMenuItem<String>>[
                                const PopupMenuItem(
                                  value: 'ログアウト',
                                  child: Text('ログアウト'),
                                )
                              ];
                            },
                            onSelected: (selectedItem) {
                              if (selectedItem == 'ログアウト') {
                                ref
                                    .read(authControllerProvider.notifier)
                                    .siginOut();
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AuthCheckPage()));
                              }
                            },
                          )
                        : const SizedBox()
                  ],
                ),
              ),
            ),
            Container(
              transform: Matrix4.translationValues(0.0, -45.0, 0.0),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundImage: widget.user.profileImageUrl!.isEmpty
                            ? const AssetImage('assets/img/placeholder.png')
                                as ImageProvider
                            : NetworkImage(widget.user.profileImageUrl!),
                      ),
                      widget.uid == widget.currentUid
                          ? GestureDetector(
                              onTap: (() async {
                                final bool? _isEdit = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditProfilePage(
                                              user: widget.user,
                                            )));
                                if (_isEdit != null && _isEdit) {
                                  ref.refresh(userStateProvider(widget.uid));
                                }
                              }),
                              child: Container(
                                width: 100,
                                height: 35,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    border: Border.all(color: mainColor)),
                                child: Center(
                                  child: Text(
                                    '編集',
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: mainColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )
                          : FollowButton(
                              currentUserId: widget.currentUid,
                              visitedUserId: widget.uid,
                            )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.user.name!,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (widget.user.discription?.isEmpty == false)
                    Text(widget.user.discription!),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      FollowText(
                        uid: widget.uid,
                        is_followes: true,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      FollowText(
                        uid: widget.uid,
                        is_followes: false,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: CupertinoSlidingSegmentedControl(
                      groupValue: _profileSegmentedValue,
                      thumbColor: mainColor,
                      backgroundColor: Colors.blueGrey,
                      children: _profileTabs,
                      onValueChanged: (i) {
                        setState(() {
                          _profileSegmentedValue = i!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            buildProfileWidgets(widget.user),
          ],
        ),
      ),
    );
  }
}

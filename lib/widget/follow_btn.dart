import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twiiter_clone2/controller/follow_controller.dart';
import 'package:twiiter_clone2/util/color.dart';

class FollowButton extends ConsumerStatefulWidget {
  const FollowButton({
    Key? key,
    required this.visitedUserId,
    required this.currentUserId,
  }) : super(key: key);

  final String currentUserId;
  final String visitedUserId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FollowButtonState();
}

class _FollowButtonState extends ConsumerState<FollowButton> {
  bool _isFollow = false;

  setupIsFollowing() async {
    _isFollow = await ref
        .read(followControllerProvider.notifier)
        .isFollowingUser(widget.currentUserId, widget.visitedUserId);
  }

  followOrUnFollow() async {
    if (_isFollow) {
      await unFollowUser();
    } else {
      await followUser();
    }
  }

  // フォロー外す
  unFollowUser() async {
    await ref
        .read(followControllerProvider.notifier)
        .unFollowUser(widget.currentUserId, widget.visitedUserId);
  }

  // フォローする
  followUser() async {
    await ref
        .read(followControllerProvider.notifier)
        .followUser(widget.currentUserId, widget.visitedUserId);
  }

  @override
  void initState() {
    super.initState();
    setupIsFollowing(); // フォローしているかの判別
  }

  @override
  Widget build(BuildContext context) {
    _isFollow = ref.watch(followControllerProvider);
    return GestureDetector(
      onTap: (() async {
        try {
          await followOrUnFollow();
        } catch (e) {
          print(e.toString());
        }
      }),
      child: Container(
        width: 110,
        height: 35,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: _isFollow ? Colors.white : mainColor,
            border: Border.all(color: mainColor)),
        child: Center(
          child: Text(
            _isFollow ? 'フォロー中' : 'フォロー',
            style: TextStyle(
                fontSize: 17,
                color: _isFollow ? mainColor : Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

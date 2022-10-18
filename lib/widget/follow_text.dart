import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone2/controller/follow_controller.dart';

class FollowText extends ConsumerWidget {
  final String uid;
  // ignore: non_constant_identifier_names
  final bool is_followes; // フォロワー表示かフォロー数表示
  // ignore: non_constant_identifier_names
  const FollowText({super.key, required this.uid, required this.is_followes});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streamFollowQuery = ref.watch(followingStateProvider(uid));
    final streamFollowerQuery = ref.watch(followerStateProvider(uid));

    if (is_followes) {
      // フォロー数表示なら
      return streamFollowQuery.when(data: (QuerySnapshot snapshot) {
        final int followingNun = snapshot.docs.length;
        return followTextWidget(
          followerNun: followingNun,
          is_followes: is_followes,
        );
      }, error: ((error, stackTrace) {
        return followTextWidget(
          followerNun: 00,
          is_followes: is_followes,
        );
      }), loading: (() {
        return followTextWidget(
          followerNun: 0000,
          is_followes: is_followes,
        );
      }));
    }
    // フォロワー数表示なら
    return streamFollowerQuery.when(data: (QuerySnapshot snapshot) {
      final int followerNun = snapshot.docs.length;
      return followTextWidget(
        followerNun: followerNun,
        is_followes: is_followes,
      );
    }, error: ((error, stackTrace) {
      return followTextWidget(
        followerNun: 00,
        is_followes: is_followes,
      );
    }), loading: (() {
      return followTextWidget(
        followerNun: 0000,
        is_followes: is_followes,
      );
    }));
  }
}

// ignore: camel_case_types
class followTextWidget extends StatelessWidget {
  const followTextWidget({
    Key? key,
    required this.followerNun,
    // ignore: non_constant_identifier_names
    required this.is_followes,
  }) : super(key: key);

  final int followerNun;
  // ignore: non_constant_identifier_names
  final bool is_followes;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$followerNun',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(is_followes ? 'フォロー中' : 'フォロワー')
      ],
    );
  }
}

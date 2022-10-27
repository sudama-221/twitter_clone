import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twiiter_clone2/controller/auth_controller.dart';
import 'package:twiiter_clone2/model/user_state.dart';
import 'package:twiiter_clone2/page/profile_page.dart';

class UserTile extends ConsumerWidget {
  const UserTile({super.key, required this.user});
  final UserState user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User? currentUser = ref.watch(currentUserProvider);
    print('visitedUser: ${user.uid}');
    print('currentUser: ${currentUser!.uid}');
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundImage: user.profileImageUrl!.isEmpty
            ? const AssetImage('assets/img/placeholder.png') as ImageProvider
            : NetworkImage(user.profileImageUrl!),
      ),
      title: Text(user.name!),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProfilePage(
                  uid: user.uid!,
                  currentUid: currentUser.uid,
                )));
      },
    );
  }
}

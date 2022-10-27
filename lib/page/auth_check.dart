import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twiiter_clone2/controller/auth_controller.dart';
import 'package:twiiter_clone2/page/feed_page.dart';
import 'package:twiiter_clone2/page/welcome_page.dart';

class AuthCheckPage extends ConsumerWidget {
  const AuthCheckPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userLogin = ref.watch(authStateProvider);

    return userLogin.when(
      data: (data) {
        if (data != null) return FeedPage(data.uid);
        return const WelcomePage();
      },
      loading: () {
        return Center(
          child: Text('ローディング'),
        );
      },
      error: (error, stackTrace) {
        return Text(error.toString());
      },
    );
  }
}

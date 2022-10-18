import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone2/controller/auth_controller.dart';
import 'package:twitter_clone2/controller/user_controller.dart';
import 'package:twitter_clone2/model/user_state.dart';
import 'package:twitter_clone2/widget/rounded_btn.dart';

class TestPage extends ConsumerWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValueuserState = ref.watch(userStateProvider('null'));

    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    final UserState? user = asyncValueuserState.value;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('テスト'),
            (user != null) ? Text(user.name!) : Text('なし'),
            Center(
              child: asyncValueuserState.when(
                data: (user) {
                  if (user != null) {
                    return Column(
                      children: [Text(user.name!)],
                    );
                  } else {
                    return const Text('プロフィールデータなし');
                  }
                },
                loading: () {
                  return const Center(
                    child: Text('ローディング'),
                  );
                },
                error: (error, stackTrace) {
                  return Text(error.toString());
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              decoration: const InputDecoration(hintText: 'メールアドレス'),
              controller: _emailController,
              onChanged: (value) {
                print('メール： $value');
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              decoration: const InputDecoration(hintText: 'パスワード'),
              controller: _passwordController,
              onChanged: (value) {
                print('パスワード $value');
              },
            ),
            const SizedBox(
              height: 40,
            ),
            RoundedBtn(
              btnText: 'ログイン',
              onBtnPressed: () async {
                await ref
                    .read(authControllerProvider.notifier)
                    .signIn(_emailController.text, _passwordController.text);
              },
            ),
            RoundedBtn(
                btnText: 'ログアウト',
                onBtnPressed: () {
                  ref.read(authControllerProvider.notifier).siginOut();
                })
          ],
        ),
      ),
    );
  }
}

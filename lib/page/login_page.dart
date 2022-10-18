import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone2/controller/auth_controller.dart';
import 'package:twitter_clone2/page/auth_check.dart';
import 'package:twitter_clone2/util/color.dart';
import 'package:twitter_clone2/widget/rounded_btn.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0,
        title: const Text(
          'ログイン',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const AuthCheckPage())));
              },
            ),
          ],
        ),
      ),
    );
  }
}

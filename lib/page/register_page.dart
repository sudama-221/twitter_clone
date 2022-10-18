import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone2/controller/auth_controller.dart';
import 'package:twitter_clone2/page/auth_check.dart';
import 'package:twitter_clone2/util/color.dart';
import 'package:twitter_clone2/widget/rounded_btn.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRead = ref.read(authControllerProvider.notifier);

    TextEditingController _nameController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0,
        title: const Text(
          '新規登録',
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
              decoration: const InputDecoration(hintText: '名前'),
              controller: _nameController,
              onChanged: (value) {
                print('名前： $value');
              },
            ),
            const SizedBox(
              height: 10,
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
              btnText: 'アカウント作成',
              onBtnPressed: () {
                // アカウント作成
                try {
                  authRead.signUp(_nameController.text, _emailController.text,
                      _passwordController.text);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AuthCheckPage()));
                } catch (e) {
                  print(e.toString());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

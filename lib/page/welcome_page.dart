import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twiiter_clone2/page/login_page.dart';
import 'package:twiiter_clone2/page/register_page.dart';
import 'package:twiiter_clone2/widget/rounded_btn.dart';

class WelcomePage extends ConsumerWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                  ),
                  Image.asset(
                    'assets/img/logo.png',
                    height: 200,
                    width: 200,
                  ),
                  const Text(
                    '英語がわからないけどウェルカムページ',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Column(
                children: [
                  RoundedBtn(
                    btnText: 'ログイン',
                    onBtnPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const LoginPage())));
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  RoundedBtn(
                    btnText: 'アカウント作成',
                    onBtnPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const RegisterPage())));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}

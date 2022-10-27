import 'package:flutter/material.dart';
import 'package:twiiter_clone2/util/color.dart';

class RoundedBtn extends StatelessWidget {
  final String btnText;
  final Function onBtnPressed;

  const RoundedBtn(
      {super.key, required this.btnText, required this.onBtnPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: mainColor,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          minimumSize: const Size(300, 50),
        ),
        onPressed: () {
          // 画面遷移
          onBtnPressed();
        },
        child: Text(
          btnText,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }
}

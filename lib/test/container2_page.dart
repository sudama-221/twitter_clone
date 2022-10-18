import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Container2 extends StatelessWidget {
  final String uid;
  const Container2({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            Text('container2'),
            Text('uid : $uid'),
          ],
        ),
      ),
    );
  }
}

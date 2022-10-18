import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone2/controller/image_pick_controller.dart';
import 'package:twitter_clone2/model/image_state.dart';
import 'package:twitter_clone2/util/color.dart';

class Container1 extends ConsumerStatefulWidget {
  const Container1({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Container1State();
}

class _Container1State extends ConsumerState<Container1> {
  displayCoverImage(ImageState imageState) {
    print('呼ばれた');
    // カバー画像の表示挙動
    if (imageState.coverImg == null) {
      return const NetworkImage(
          'https://firebasestorage.googleapis.com/v0/b/twitter-clone-5398c.appspot.com/o/users%2Fcover63cSYzVrDkh8O67QDpxnPjcrfhg1.jpg?alt=media&token=c54bbfff-e8c3-49aa-9179-e9ccc715e92b');
    }
    return FileImage(imageState.coverImg!);
  }

  @override
  Widget build(BuildContext context) {
    File? _profileImage;
    File? _coverImage;
    String? _imagePickedType;
    ImageState? imageState = ref.watch(imagePickProvider);

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () async {
            _imagePickedType = 'cover';
            await ref
                .read(imagePickProvider.notifier)
                .imagePick(_imagePickedType!);
          },
          child: Stack(
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                    color: mainColor,
                    image: imageState?.coverImg == null
                        ? null
                        : DecorationImage(
                            image: displayCoverImage(imageState!),
                            fit: BoxFit.cover)),
              ),
              Container(
                height: 150,
                color: Colors.black54,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.camera_alt,
                      size: 70,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

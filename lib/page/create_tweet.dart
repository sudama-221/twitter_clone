import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twiiter_clone2/controller/auth_controller.dart';
import 'package:twiiter_clone2/controller/image_pick_controller.dart';
import 'package:twiiter_clone2/controller/loading_controller.dart';
import 'package:twiiter_clone2/controller/tweet_controller.dart';
import 'package:twiiter_clone2/model/image_state.dart';
import 'package:twiiter_clone2/model/tweet_state.dart';
import 'package:twiiter_clone2/util/color.dart';
import 'package:twiiter_clone2/widget/rounded_btn.dart';

class CreateTweetPage extends ConsumerWidget {
  const CreateTweetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? _imagePickedType;
    final _read = ref.read;
    TextEditingController _tweetController = TextEditingController();

    ImageState imageState;

    bool _isLoading = ref.watch(LoadingProvider);
    User? currentUser = ref.watch(currentUserProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('ツイート'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextField(
                maxLength: 280,
                maxLines: 7,
                decoration: const InputDecoration(hintText: '今何してる？'),
                controller: _tweetController,
                onChanged: (value) {
                  print('名前： $value');
                },
              ),
              const SizedBox(height: 10),
              Consumer(
                builder: (context, ref, child) {
                  ImageState imageState = ref.watch(imagePickProvider);
                  if (imageState.tweetImg == null) {
                    return const SizedBox.shrink();
                  }
                  {
                    return Column(
                      children: [
                        Container(
                          height: 300,
                          decoration: BoxDecoration(
                              color: mainColor,
                              image: DecorationImage(
                                  image: FileImage(imageState.tweetImg!),
                                  fit: BoxFit.cover)),
                        ),
                      ],
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  _imagePickedType = 'tweet';
                  await ref
                      .read(imagePickProvider.notifier)
                      .imagePick(_imagePickedType!);
                },
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(color: mainColor, width: 2)),
                  child: Icon(
                    Icons.camera_alt,
                    color: mainColor,
                    size: 50,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Consumer(
                builder: (context, ref, child) {
                  ImageState imageState = ref.watch(imagePickProvider);
                  return RoundedBtn(
                      btnText: 'ツイートする',
                      onBtnPressed: () async {
                        _read(LoadingProvider.notifier).startLoading();
                        if (_tweetController.text.isNotEmpty) {
                          String image;
                          if (imageState.tweetImg == null) {
                            image = '';
                          } else {
                            // storageに保存してURLを取得する
                            image = await _read(tweetProvider.notifier)
                                .tweetImgUpload(imageState.tweetImg!);
                          }

                          // ツイート情報をモデルへ
                          TweetState tweetState = TweetState(
                              text: _tweetController.text,
                              imageUrl: image,
                              authorId: currentUser!.uid,
                              likes: 0,
                              retweets: 0,
                              timestamp: Timestamp.fromDate(DateTime.now()));

                          await _read(tweetProvider.notifier)
                              .createTweet(tweetState);
                        }
                        _read(LoadingProvider.notifier).endLoading();
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      });
                },
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : const SizedBox.shrink()
            ],
          ),
        ));
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone2/controller/image_pick_controller.dart';
import 'package:twitter_clone2/controller/loading_controller.dart';
import 'package:twitter_clone2/controller/user_controller.dart';
import 'package:twitter_clone2/model/image_state.dart';
import 'package:twitter_clone2/model/user_state.dart';
import 'package:twitter_clone2/util/color.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({
    Key? key,
    required this.user,
  }) : super(key: key);
  final UserState user;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  // 保存するまでの保管箇所
  String? _name;
  String? _discription;
  File? _profileImage;
  File? _coverImage;
  String? _imagePickedType;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  File? imageFile; // 画像を一旦保管する

  displayProfileImage(ImageState imageState) {
    // プロフ画像の表示挙動
    if (imageState.profileImg == null) {
      if (widget.user.profileImageUrl!.isEmpty) {
        // 画像が何も無い状況
        return const AssetImage('assets/img/placeholder.png');
      } else {
        return NetworkImage(widget.user.profileImageUrl!);
      }
    } else {
      return FileImage(imageState.profileImg!);
    }
  }

  displayCoverImage(ImageState imageState) {
    // カバー画像の表示挙動
    if (imageState.coverImg == null) {
      if (widget.user.coverImageUrl!.isNotEmpty) {
        // 画像が何も無い状況
        return NetworkImage(widget.user.coverImageUrl!);
      }
    } else {
      return FileImage(imageState.coverImg!);
    }
  }

  saveProfile(Reader _read, ImageState imageState) async {
// 保存
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate() && !_isLoading) {
      try {
        _read(LoadingProvider.notifier).startLoading();

        // 画像の設定がなければ
        String uploadProfileImageUrl;
        String uploadCoverImageUrl;

        if (imageState.profileImg == null) {
          uploadProfileImageUrl = widget.user.profileImageUrl!;
        } else {
          uploadProfileImageUrl = await _read(userUpdateProvider.notifier)
              .uploadImage(widget.user.uid!, imageState.profileImg!, 'profile');
        }
        if (imageState.coverImg == null) {
          uploadCoverImageUrl = widget.user.coverImageUrl!;
        } else {
          uploadCoverImageUrl = await _read(userUpdateProvider.notifier)
              .uploadImage(widget.user.uid!, imageState.coverImg!, 'cover');
        }
// 更新
        await _read(userUpdateProvider.notifier).updateProfile(widget.user.uid!,
            _name, _discription, uploadProfileImageUrl, uploadCoverImageUrl);
      } catch (e) {
        print(e.toString());
      } finally {
        _read(LoadingProvider.notifier).endLoading();
        Navigator.of(context).pop(true);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _name = widget.user.name;
    _discription = widget.user.discription;
  }

  @override
  Widget build(BuildContext context) {
    ImageState imageState = ref.watch(imagePickProvider);
    bool _isLoading = ref.watch(LoadingProvider);

    Reader _read = ref.read;

    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: [
          GestureDetector(
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
                      image: imageState.coverImg == null &&
                              widget.user.coverImageUrl!.isEmpty
                          ? null
                          : DecorationImage(
                              image: displayCoverImage(imageState),
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
          Container(
            transform: Matrix4.translationValues(0.0, -45.0, 0.0),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        _imagePickedType = 'profile';
                        await ref
                            .read(imagePickProvider.notifier)
                            .imagePick(_imagePickedType!);
                      },
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 45,
                            backgroundImage: displayProfileImage(imageState),
                          ),
                          CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.black54,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: const [
                                Icon(
                                  Icons.camera_alt,
                                  size: 25,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (() async {
                        await saveProfile(_read, imageState);
                      }),
                      child: Container(
                        width: 100,
                        height: 35,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: mainColor,
                        ),
                        child: const Center(
                          child: Text(
                            '保存',
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        initialValue: _name,
                        decoration: InputDecoration(
                          labelText: '名前',
                          labelStyle: TextStyle(color: mainColor),
                        ),
                        validator: (input) =>
                            input!.trim().length < 2 ? '2文字以上記入してください' : null,
                        onSaved: (newValue) {
                          _name = newValue!;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        initialValue: _discription,
                        decoration: InputDecoration(
                          labelText: '自己紹介',
                          labelStyle: TextStyle(color: mainColor),
                        ),
                        onSaved: (newValue) {
                          _discription = newValue!;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _isLoading
                          ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(mainColor),
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

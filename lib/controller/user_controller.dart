import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone2/controller/base_auth_controller.dart';
import 'package:twitter_clone2/model/user_state.dart';
import 'package:twitter_clone2/repository/auth_repository.dart';
import 'package:twitter_clone2/repository/user_repository.dart';

// 取得したユーザーIDから情報を受け取る
final userStateProvider =
    FutureProvider.family<UserState?, String>((ref, uid) async {
  if (uid != 'null') {
    var userData = await ref.read(authRepositoryProvider).feachUser(uid);
    return userData;
  } else {
    return null;
  }
});

final userUpdateProvider =
    StateNotifierProvider<userUpdateNotifier, List<UserState>?>((ref) {
  return userUpdateNotifier(ref.read);
});

class userUpdateNotifier extends StateNotifier<List<UserState>?> {
  final Reader _read;
  userUpdateNotifier(this._read) : super(null);

  String? _name;
  String? _discription;
  String? _profileImage;
  String? _coverImage;

  Future<String> uploadImage(String uid, File imgFile, String fileType) async {
    String imgUrl = '';

    final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': imgFile.path});
    UploadTask uploadTask;
    Reference ref = _read(firebaseStorageProvider)
        .ref()
        .child('users')
        .child('/$fileType$uid.jpg');

    // firestorageにアップロード
    try {
      uploadTask = ref.putData(await imgFile.readAsBytes(), metadata);
      imgUrl = await (await uploadTask).ref.getDownloadURL();
    } catch (e) {
      print(e.toString());
    }
    return imgUrl;
  }

  Future<void> updateProfile(String uid, String? name, String? discription,
      String profileImg, String coverImg) async {
    await _read(userRef).doc(uid).update({
      'name': name,
      'discription': discription,
      'profileImageUrl': profileImg,
      'coverImageUrl': coverImg
    });
  }

  Future<void> searchUser(String name) async {
    QuerySnapshot querySnapshot =
        await _read(userRepositoryProvider).searchUser(name);
    if (querySnapshot.size > 0) {
      final userList =
          querySnapshot.docs.map((doc) => UserState.fromDoc(doc)).toList();
      print(userList);
      state = userList;
    } else {
      state = [];
    }
  }

  void reset() {
    state = null;
  }
}

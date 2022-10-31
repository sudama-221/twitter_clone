import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twiiter_clone2/model/image_state.dart';
import 'package:twiiter_clone2/repository/image_pick_repository.dart';

final imagePickProvider =
    StateNotifierProvider.autoDispose<imagePickNotifier, ImageState>((ref) {
  return imagePickNotifier(ref);
});

class imagePickNotifier extends StateNotifier<ImageState> {
  final Ref _ref;
  imagePickNotifier(this._ref) : super(const ImageState());
  File? _imgFile; // 一旦画像保管

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> imagePick(String imgType) async {
//画像選択
    _imgFile = await _ref.read(imageRepositoryProvider).imagePick();
    if (_imgFile != null) {
      if (imgType == 'cover') {
        state = state.copyWith(coverImg: _imgFile);
      } else if (imgType == 'profile') {
        state = state.copyWith(profileImg: _imgFile);
      } else if (imgType == 'tweet') {
        state = state.copyWith(tweetImg: _imgFile);
      }
    }
  }
}

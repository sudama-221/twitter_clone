import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_state.freezed.dart';

@freezed
class ImageState with _$ImageState {
  const factory ImageState({
    File? coverImg,
    File? profileImg,
    File? tweetImg,
  }) = _ImageState;
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'likes_state.freezed.dart';

@freezed
class LikesState with _$LikesState {
  const factory LikesState({
    String? userId,
    String? tweetId,
    bool? isLiked,
  }) = _LikesState;
}

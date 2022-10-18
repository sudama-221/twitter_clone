import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:twitter_clone2/model/tweet_state.dart';

part 'likes_state.freezed.dart';

@freezed
class LikesState with _$LikesState {
  const factory LikesState({
    String? userId,
    TweetState? tweet,
  }) = _LikesState;
}

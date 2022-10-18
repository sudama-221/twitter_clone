// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'likes_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LikesState {
  String? get userId => throw _privateConstructorUsedError;
  TweetState? get tweet => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LikesStateCopyWith<LikesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LikesStateCopyWith<$Res> {
  factory $LikesStateCopyWith(
          LikesState value, $Res Function(LikesState) then) =
      _$LikesStateCopyWithImpl<$Res>;
  $Res call({String? userId, TweetState? tweet});

  $TweetStateCopyWith<$Res>? get tweet;
}

/// @nodoc
class _$LikesStateCopyWithImpl<$Res> implements $LikesStateCopyWith<$Res> {
  _$LikesStateCopyWithImpl(this._value, this._then);

  final LikesState _value;
  // ignore: unused_field
  final $Res Function(LikesState) _then;

  @override
  $Res call({
    Object? userId = freezed,
    Object? tweet = freezed,
  }) {
    return _then(_value.copyWith(
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      tweet: tweet == freezed
          ? _value.tweet
          : tweet // ignore: cast_nullable_to_non_nullable
              as TweetState?,
    ));
  }

  @override
  $TweetStateCopyWith<$Res>? get tweet {
    if (_value.tweet == null) {
      return null;
    }

    return $TweetStateCopyWith<$Res>(_value.tweet!, (value) {
      return _then(_value.copyWith(tweet: value));
    });
  }
}

/// @nodoc
abstract class _$$_LikesStateCopyWith<$Res>
    implements $LikesStateCopyWith<$Res> {
  factory _$$_LikesStateCopyWith(
          _$_LikesState value, $Res Function(_$_LikesState) then) =
      __$$_LikesStateCopyWithImpl<$Res>;
  @override
  $Res call({String? userId, TweetState? tweet});

  @override
  $TweetStateCopyWith<$Res>? get tweet;
}

/// @nodoc
class __$$_LikesStateCopyWithImpl<$Res> extends _$LikesStateCopyWithImpl<$Res>
    implements _$$_LikesStateCopyWith<$Res> {
  __$$_LikesStateCopyWithImpl(
      _$_LikesState _value, $Res Function(_$_LikesState) _then)
      : super(_value, (v) => _then(v as _$_LikesState));

  @override
  _$_LikesState get _value => super._value as _$_LikesState;

  @override
  $Res call({
    Object? userId = freezed,
    Object? tweet = freezed,
  }) {
    return _then(_$_LikesState(
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      tweet: tweet == freezed
          ? _value.tweet
          : tweet // ignore: cast_nullable_to_non_nullable
              as TweetState?,
    ));
  }
}

/// @nodoc

class _$_LikesState implements _LikesState {
  const _$_LikesState({this.userId, this.tweet});

  @override
  final String? userId;
  @override
  final TweetState? tweet;

  @override
  String toString() {
    return 'LikesState(userId: $userId, tweet: $tweet)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LikesState &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality().equals(other.tweet, tweet));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(userId),
      const DeepCollectionEquality().hash(tweet));

  @JsonKey(ignore: true)
  @override
  _$$_LikesStateCopyWith<_$_LikesState> get copyWith =>
      __$$_LikesStateCopyWithImpl<_$_LikesState>(this, _$identity);
}

abstract class _LikesState implements LikesState {
  const factory _LikesState({final String? userId, final TweetState? tweet}) =
      _$_LikesState;

  @override
  String? get userId;
  @override
  TweetState? get tweet;
  @override
  @JsonKey(ignore: true)
  _$$_LikesStateCopyWith<_$_LikesState> get copyWith =>
      throw _privateConstructorUsedError;
}

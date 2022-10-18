// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'tweet_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TweetState {
  String? get id => throw _privateConstructorUsedError;
  String? get authorId => throw _privateConstructorUsedError;
  Timestamp? get timestamp => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  int? get likes => throw _privateConstructorUsedError;
  int? get retweets => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TweetStateCopyWith<TweetState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TweetStateCopyWith<$Res> {
  factory $TweetStateCopyWith(
          TweetState value, $Res Function(TweetState) then) =
      _$TweetStateCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String? authorId,
      Timestamp? timestamp,
      DateTime? createdAt,
      String? text,
      String? imageUrl,
      int? likes,
      int? retweets});
}

/// @nodoc
class _$TweetStateCopyWithImpl<$Res> implements $TweetStateCopyWith<$Res> {
  _$TweetStateCopyWithImpl(this._value, this._then);

  final TweetState _value;
  // ignore: unused_field
  final $Res Function(TweetState) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? authorId = freezed,
    Object? timestamp = freezed,
    Object? createdAt = freezed,
    Object? text = freezed,
    Object? imageUrl = freezed,
    Object? likes = freezed,
    Object? retweets = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      authorId: authorId == freezed
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: timestamp == freezed
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as Timestamp?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: imageUrl == freezed
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      likes: likes == freezed
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as int?,
      retweets: retweets == freezed
          ? _value.retweets
          : retweets // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$$_TweetStateCopyWith<$Res>
    implements $TweetStateCopyWith<$Res> {
  factory _$$_TweetStateCopyWith(
          _$_TweetState value, $Res Function(_$_TweetState) then) =
      __$$_TweetStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String? authorId,
      Timestamp? timestamp,
      DateTime? createdAt,
      String? text,
      String? imageUrl,
      int? likes,
      int? retweets});
}

/// @nodoc
class __$$_TweetStateCopyWithImpl<$Res> extends _$TweetStateCopyWithImpl<$Res>
    implements _$$_TweetStateCopyWith<$Res> {
  __$$_TweetStateCopyWithImpl(
      _$_TweetState _value, $Res Function(_$_TweetState) _then)
      : super(_value, (v) => _then(v as _$_TweetState));

  @override
  _$_TweetState get _value => super._value as _$_TweetState;

  @override
  $Res call({
    Object? id = freezed,
    Object? authorId = freezed,
    Object? timestamp = freezed,
    Object? createdAt = freezed,
    Object? text = freezed,
    Object? imageUrl = freezed,
    Object? likes = freezed,
    Object? retweets = freezed,
  }) {
    return _then(_$_TweetState(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      authorId: authorId == freezed
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: timestamp == freezed
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as Timestamp?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: imageUrl == freezed
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      likes: likes == freezed
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as int?,
      retweets: retweets == freezed
          ? _value.retweets
          : retweets // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_TweetState implements _TweetState {
  const _$_TweetState(
      {this.id,
      this.authorId,
      this.timestamp,
      this.createdAt,
      this.text,
      this.imageUrl,
      this.likes,
      this.retweets});

  @override
  final String? id;
  @override
  final String? authorId;
  @override
  final Timestamp? timestamp;
  @override
  final DateTime? createdAt;
  @override
  final String? text;
  @override
  final String? imageUrl;
  @override
  final int? likes;
  @override
  final int? retweets;

  @override
  String toString() {
    return 'TweetState(id: $id, authorId: $authorId, timestamp: $timestamp, createdAt: $createdAt, text: $text, imageUrl: $imageUrl, likes: $likes, retweets: $retweets)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TweetState &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.authorId, authorId) &&
            const DeepCollectionEquality().equals(other.timestamp, timestamp) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.text, text) &&
            const DeepCollectionEquality().equals(other.imageUrl, imageUrl) &&
            const DeepCollectionEquality().equals(other.likes, likes) &&
            const DeepCollectionEquality().equals(other.retweets, retweets));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(authorId),
      const DeepCollectionEquality().hash(timestamp),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(text),
      const DeepCollectionEquality().hash(imageUrl),
      const DeepCollectionEquality().hash(likes),
      const DeepCollectionEquality().hash(retweets));

  @JsonKey(ignore: true)
  @override
  _$$_TweetStateCopyWith<_$_TweetState> get copyWith =>
      __$$_TweetStateCopyWithImpl<_$_TweetState>(this, _$identity);
}

abstract class _TweetState implements TweetState {
  const factory _TweetState(
      {final String? id,
      final String? authorId,
      final Timestamp? timestamp,
      final DateTime? createdAt,
      final String? text,
      final String? imageUrl,
      final int? likes,
      final int? retweets}) = _$_TweetState;

  @override
  String? get id;
  @override
  String? get authorId;
  @override
  Timestamp? get timestamp;
  @override
  DateTime? get createdAt;
  @override
  String? get text;
  @override
  String? get imageUrl;
  @override
  int? get likes;
  @override
  int? get retweets;
  @override
  @JsonKey(ignore: true)
  _$$_TweetStateCopyWith<_$_TweetState> get copyWith =>
      throw _privateConstructorUsedError;
}

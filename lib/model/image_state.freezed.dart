// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'image_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ImageState {
  File? get coverImg => throw _privateConstructorUsedError;
  File? get profileImg => throw _privateConstructorUsedError;
  File? get tweetImg => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ImageStateCopyWith<ImageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageStateCopyWith<$Res> {
  factory $ImageStateCopyWith(
          ImageState value, $Res Function(ImageState) then) =
      _$ImageStateCopyWithImpl<$Res, ImageState>;
  @useResult
  $Res call({File? coverImg, File? profileImg, File? tweetImg});
}

/// @nodoc
class _$ImageStateCopyWithImpl<$Res, $Val extends ImageState>
    implements $ImageStateCopyWith<$Res> {
  _$ImageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coverImg = freezed,
    Object? profileImg = freezed,
    Object? tweetImg = freezed,
  }) {
    return _then(_value.copyWith(
      coverImg: freezed == coverImg
          ? _value.coverImg
          : coverImg // ignore: cast_nullable_to_non_nullable
              as File?,
      profileImg: freezed == profileImg
          ? _value.profileImg
          : profileImg // ignore: cast_nullable_to_non_nullable
              as File?,
      tweetImg: freezed == tweetImg
          ? _value.tweetImg
          : tweetImg // ignore: cast_nullable_to_non_nullable
              as File?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ImageStateCopyWith<$Res>
    implements $ImageStateCopyWith<$Res> {
  factory _$$_ImageStateCopyWith(
          _$_ImageState value, $Res Function(_$_ImageState) then) =
      __$$_ImageStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({File? coverImg, File? profileImg, File? tweetImg});
}

/// @nodoc
class __$$_ImageStateCopyWithImpl<$Res>
    extends _$ImageStateCopyWithImpl<$Res, _$_ImageState>
    implements _$$_ImageStateCopyWith<$Res> {
  __$$_ImageStateCopyWithImpl(
      _$_ImageState _value, $Res Function(_$_ImageState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coverImg = freezed,
    Object? profileImg = freezed,
    Object? tweetImg = freezed,
  }) {
    return _then(_$_ImageState(
      coverImg: freezed == coverImg
          ? _value.coverImg
          : coverImg // ignore: cast_nullable_to_non_nullable
              as File?,
      profileImg: freezed == profileImg
          ? _value.profileImg
          : profileImg // ignore: cast_nullable_to_non_nullable
              as File?,
      tweetImg: freezed == tweetImg
          ? _value.tweetImg
          : tweetImg // ignore: cast_nullable_to_non_nullable
              as File?,
    ));
  }
}

/// @nodoc

class _$_ImageState implements _ImageState {
  const _$_ImageState({this.coverImg, this.profileImg, this.tweetImg});

  @override
  final File? coverImg;
  @override
  final File? profileImg;
  @override
  final File? tweetImg;

  @override
  String toString() {
    return 'ImageState(coverImg: $coverImg, profileImg: $profileImg, tweetImg: $tweetImg)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ImageState &&
            (identical(other.coverImg, coverImg) ||
                other.coverImg == coverImg) &&
            (identical(other.profileImg, profileImg) ||
                other.profileImg == profileImg) &&
            (identical(other.tweetImg, tweetImg) ||
                other.tweetImg == tweetImg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, coverImg, profileImg, tweetImg);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ImageStateCopyWith<_$_ImageState> get copyWith =>
      __$$_ImageStateCopyWithImpl<_$_ImageState>(this, _$identity);
}

abstract class _ImageState implements ImageState {
  const factory _ImageState(
      {final File? coverImg,
      final File? profileImg,
      final File? tweetImg}) = _$_ImageState;

  @override
  File? get coverImg;
  @override
  File? get profileImg;
  @override
  File? get tweetImg;
  @override
  @JsonKey(ignore: true)
  _$$_ImageStateCopyWith<_$_ImageState> get copyWith =>
      throw _privateConstructorUsedError;
}

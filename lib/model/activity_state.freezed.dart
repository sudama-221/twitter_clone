// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'activity_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ActivityState {
  String? get id => throw _privateConstructorUsedError;
  String? get fromUserId => throw _privateConstructorUsedError;
  Timestamp? get timestamp => throw _privateConstructorUsedError;
  bool? get follow => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ActivityStateCopyWith<ActivityState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivityStateCopyWith<$Res> {
  factory $ActivityStateCopyWith(
          ActivityState value, $Res Function(ActivityState) then) =
      _$ActivityStateCopyWithImpl<$Res, ActivityState>;
  @useResult
  $Res call(
      {String? id, String? fromUserId, Timestamp? timestamp, bool? follow});
}

/// @nodoc
class _$ActivityStateCopyWithImpl<$Res, $Val extends ActivityState>
    implements $ActivityStateCopyWith<$Res> {
  _$ActivityStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? fromUserId = freezed,
    Object? timestamp = freezed,
    Object? follow = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      fromUserId: freezed == fromUserId
          ? _value.fromUserId
          : fromUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as Timestamp?,
      follow: freezed == follow
          ? _value.follow
          : follow // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ActivityStateCopyWith<$Res>
    implements $ActivityStateCopyWith<$Res> {
  factory _$$_ActivityStateCopyWith(
          _$_ActivityState value, $Res Function(_$_ActivityState) then) =
      __$$_ActivityStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id, String? fromUserId, Timestamp? timestamp, bool? follow});
}

/// @nodoc
class __$$_ActivityStateCopyWithImpl<$Res>
    extends _$ActivityStateCopyWithImpl<$Res, _$_ActivityState>
    implements _$$_ActivityStateCopyWith<$Res> {
  __$$_ActivityStateCopyWithImpl(
      _$_ActivityState _value, $Res Function(_$_ActivityState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? fromUserId = freezed,
    Object? timestamp = freezed,
    Object? follow = freezed,
  }) {
    return _then(_$_ActivityState(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      fromUserId: freezed == fromUserId
          ? _value.fromUserId
          : fromUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as Timestamp?,
      follow: freezed == follow
          ? _value.follow
          : follow // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class _$_ActivityState implements _ActivityState {
  const _$_ActivityState(
      {this.id, this.fromUserId, this.timestamp, this.follow});

  @override
  final String? id;
  @override
  final String? fromUserId;
  @override
  final Timestamp? timestamp;
  @override
  final bool? follow;

  @override
  String toString() {
    return 'ActivityState(id: $id, fromUserId: $fromUserId, timestamp: $timestamp, follow: $follow)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ActivityState &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fromUserId, fromUserId) ||
                other.fromUserId == fromUserId) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.follow, follow) || other.follow == follow));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, fromUserId, timestamp, follow);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ActivityStateCopyWith<_$_ActivityState> get copyWith =>
      __$$_ActivityStateCopyWithImpl<_$_ActivityState>(this, _$identity);
}

abstract class _ActivityState implements ActivityState {
  const factory _ActivityState(
      {final String? id,
      final String? fromUserId,
      final Timestamp? timestamp,
      final bool? follow}) = _$_ActivityState;

  @override
  String? get id;
  @override
  String? get fromUserId;
  @override
  Timestamp? get timestamp;
  @override
  bool? get follow;
  @override
  @JsonKey(ignore: true)
  _$$_ActivityStateCopyWith<_$_ActivityState> get copyWith =>
      throw _privateConstructorUsedError;
}

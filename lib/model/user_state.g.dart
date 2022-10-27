// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserState _$$_UserStateFromJson(Map<String, dynamic> json) => _$_UserState(
      uid: json['uid'] as String?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      discription: json['discription'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      coverImageUrl: json['coverImageUrl'] as String?,
    );

Map<String, dynamic> _$$_UserStateToJson(_$_UserState instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'name': instance.name,
      'discription': instance.discription,
      'profileImageUrl': instance.profileImageUrl,
      'coverImageUrl': instance.coverImageUrl,
    };

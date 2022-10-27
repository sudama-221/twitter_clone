import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_state.freezed.dart';
part 'user_state.g.dart';

@freezed
class UserState with _$UserState {
  const factory UserState({
    String? uid,
    String? email,
    String? name,
    String? discription,
    String? profileImageUrl,
    String? coverImageUrl,
  }) = _UserState;

  factory UserState.fromDoc(DocumentSnapshot doc) {
    return UserState(
        uid: doc.id,
        name: doc['name'],
        email: doc['email'],
        discription: doc['discription'],
        profileImageUrl: doc['profileImageUrl'],
        coverImageUrl: doc['coverImageUrl']);
  }

  factory UserState.fromJson(Map<String, dynamic> json) =>
      _$UserStateFromJson(json);
}

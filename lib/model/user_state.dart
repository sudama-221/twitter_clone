import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_state.freezed.dart';

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
}

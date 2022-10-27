import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_state.freezed.dart';

@freezed
class ActivityState with _$ActivityState {
  const factory ActivityState({
    String? id,
    String? fromUserId,
    Timestamp? timestamp,
    bool? follow, // ログインしているユーザーがリツイートしているか
  }) = _ActivityState;

  factory ActivityState.fromDoc(DocumentSnapshot doc) {
    return ActivityState(
      id: doc.id,
      fromUserId: doc['fromUserId'],
      timestamp: doc['timestamp'],
      follow: doc['follow'],
    );
  }
}

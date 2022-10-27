import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tweet_state.freezed.dart';

@freezed
class TweetState with _$TweetState {
  const factory TweetState({
    String? id,
    String? authorId,
    Timestamp? timestamp,
    DateTime? createdAt,
    String? text,
    String? imageUrl,
    int? likes,
    int? retweets,
    bool? isLiked, // ログインしているユーザーがいいねしているか
    bool? isRetweet, // ログインしているユーザーがリツイートしているか
  }) = _TweetState;

  factory TweetState.fromDoc(DocumentSnapshot doc) {
    DateTime createdAt;
    createdAt = doc['timestamp'].toDate();

    return TweetState(
      id: doc.id,
      authorId: doc['authorId'],
      timestamp: doc['timestamp'],
      createdAt: createdAt,
      text: doc['text'],
      imageUrl: doc['image'],
      likes: doc['likes'],
      retweets: doc['retweets'],
    );
  }
}

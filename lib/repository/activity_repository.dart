import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twiiter_clone2/controller/base_auth_controller.dart';
import 'package:twiiter_clone2/model/activity_state.dart';

abstract class BaseActivityRepository {
  Future<List<ActivityState>> getActivities(String userId);
}

final activityRepositoryProvider =
    Provider.autoDispose<ActivityRepository>((ref) {
  return ActivityRepository(ref);
});

class ActivityRepository implements BaseActivityRepository {
  final Ref _ref;
  const ActivityRepository(this._ref);

  Future<List<ActivityState>> getActivities(String userId) async {
    QuerySnapshot userActivitiesSnapshot = await _ref
        .read(activitiesRef)
        .doc(userId)
        .collection('userActivities')
        .orderBy('timestamp', descending: true)
        .get();

    List<ActivityState> activities = userActivitiesSnapshot.docs
        .map((doc) => ActivityState.fromDoc(doc))
        .toList();

    return activities;
  }
}

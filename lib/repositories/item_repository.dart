import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/extensions/firestore_extension.dart';
import 'package:riverpod_app/general_providers.dart';
import 'package:riverpod_app/model/item_model.dart';
import 'package:riverpod_app/repositories/custom_exception.dart';

abstract class BaseItemRepository {
  Future<List<Item>> retrieveItems({required String userId});
  Future<String> createItem({required String userId, required Item item});
  Future<void> updateItem({required String userId, required Item item});
  Future<void> deleteItem({required String userId, required String itemId});
}

final ItemRepositoryProvider =
    Provider.autoDispose<BaseItemRepository>((ref) => ItemRepository(ref));

class ItemRepository implements BaseItemRepository {
  final Ref _ref;
  const ItemRepository(this._ref);

  // 取得する
  @override
  Future<List<Item>> retrieveItems({required String userId}) async {
    try {
      final snap = await _ref.read(firestoreProvider).userListRef(userId).get();
      return snap.docs.map((doc) => Item.fromDoc(doc)).toList();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<String> createItem(
      {required String userId, required Item item}) async {
    try {
      final docRef = await _ref
          .read(firestoreProvider)
          .userListRef(userId)
          .add(item.toDoc());
      return docRef.id;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> updateItem({required String userId, required Item item}) async {
    try {
      await _ref
          .read(firestoreProvider)
          .userListRef(userId)
          .doc(item.id)
          .update(item.toDoc());
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> deleteItem(
      {required String userId, required String itemId}) async {
    try {
      await _ref
          .read(firestoreProvider)
          .userListRef(userId)
          .doc(itemId)
          .delete();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}

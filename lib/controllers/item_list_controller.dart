import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/controllers/auth_controller.dart';
import 'package:riverpod_app/model/item_model.dart';
import 'package:riverpod_app/repositories/custom_exception.dart';
import 'package:riverpod_app/repositories/item_repository.dart';

// フィルター機能
enum ItemListFilter {
  all, // 全て
  abtained // チェック済み
}

final itemListFilterProvider = StateProvider<ItemListFilter>((_) {
  return ItemListFilter.all;
});

final filteredItemListProvider = Provider<List<Item>>((ref) {
  final itemListFilterState = ref.watch(itemListFilterProvider);
  final itemListState = ref.watch(itemListControllerProvider);
  print('object');
  return itemListState.maybeWhen(
    orElse: () => [],
    data: (items) {
      switch (itemListFilterState) {
        case ItemListFilter.abtained: // チェック済みのやつ
          print('チェック済み');
          return items.where((item) => item.obtained).toList();
        default:
          return items;
      }
    },
  );
});

// エラー状況を管理
final itemListExceptionProvider = StateProvider<CustomException?>((_) => null);

final itemListControllerProvider =
    StateNotifierProvider<itemListController, AsyncValue<List<Item>>>(
  (ref) {
    final user = ref.watch(authControllerProvider);
    return itemListController(ref, user?.uid);
  },
);

class itemListController extends StateNotifier<AsyncValue<List<Item>>> {
  final Ref _ref;
  final String? _userId;

  itemListController(this._ref, this._userId) : super(AsyncValue.loading()) {
    if (_userId != null) {
      retrieveItem();
    }
  }

  // 取得する
  Future<void> retrieveItem({bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      final items = await _ref
          .read(ItemRepositoryProvider)
          .retrieveItems(userId: _userId!);
      if (mounted) {
        state = AsyncValue.data(items);
      }
    } on CustomException catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  // 追加する
  Future<void> addItem({required String name, bool obtained = false}) async {
    try {
      final item = Item(name: name, obtained: obtained);
      final itemId = await _ref
          .read(ItemRepositoryProvider)
          .createItem(userId: _userId!, item: item);
      state.whenData((items) =>
          state = AsyncValue.data(items..add(item.copyWith(id: itemId))));
    } on CustomException catch (e) {
      _ref.read(itemListExceptionProvider.notifier).state = e;
    }
  }

  // 更新する
  Future<void> updateItem({required Item updatedItem}) async {
    try {
      await _ref
          .read(ItemRepositoryProvider)
          .updateItem(userId: _userId!, item: updatedItem);
      state.whenData((items) {
        state = AsyncValue.data([
          for (final item in items)
            if (item.id == updatedItem.id) updatedItem else item
        ]);
      });
    } on CustomException catch (e) {
      _ref.read(itemListExceptionProvider.notifier).state = e;
    }
  }

  // 削除する
  Future<void> deletedItem({required String itemId}) async {
    try {
      await _ref
          .read(ItemRepositoryProvider)
          .deleteItem(userId: _userId!, itemId: itemId);
      state.whenData((items) => state =
          AsyncValue.data(items..removeWhere((item) => item.id == itemId)));
    } on CustomException catch (e) {
      _ref.read(itemListExceptionProvider.notifier).state = e;
    }
  }
}

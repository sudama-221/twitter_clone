import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/components/item_error_w.dart';
import 'package:riverpod_app/components/item_tile_w.dart';
import 'package:riverpod_app/controllers/item_list_controller.dart';
import 'package:riverpod_app/model/item_model.dart';
import 'package:riverpod_app/repositories/custom_exception.dart';

final currentItem = Provider<Item>((ref) {
  return throw UnimplementedError();
});

class ItemList extends ConsumerWidget {
  const ItemList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemListState = ref.watch(itemListControllerProvider);
    final filterdItemList = ref.watch(filteredItemListProvider); // フィルターされたアイテム

    print(filterdItemList);

    return itemListState.when(
      data: (items) => items.isEmpty
          ? const Center(
              child: Text(
                'アイテムを追加してください',
                style: TextStyle(fontSize: 20.0),
              ),
            )
          : ListView.builder(
              itemCount: filterdItemList.length,
              itemBuilder: (BuildContext context, int index) {
                final item = filterdItemList[index];
                return ProviderScope(
                  overrides: [currentItem.overrideWithValue(item)],
                  child: itemTile(item: item),
                );
              }),
      error: (error, stackTrace) => itemListError(
          message: error is CustomException ? error.message! : 'エラーが発生しました'),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/components/item_list_w.dart';
import 'package:riverpod_app/controllers/auth_controller.dart';
import 'package:riverpod_app/controllers/item_list_controller.dart';
import 'package:riverpod_app/model/item_model.dart';
import 'package:riverpod_app/repositories/custom_exception.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authCotrollerState = ref.watch(authControllerProvider);
    // フィルターされたアイテム
    final itemListFilter = ref.watch(itemListFilterProvider);
    // フィルターされたものがチェックされたもの(obtained)か判別 true or false
    final isObtainedFilter = itemListFilter == ItemListFilter.abtained;

    ref.listen<CustomException?>(itemListExceptionProvider,
        (CustomException? customException, next) {
      print('エラー：$customException');
    });
    print(itemListFilter);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List'),
        leading: authCotrollerState != null
            ? IconButton(
                onPressed: () {
                  ref.read(authControllerProvider.notifier).signOut();
                },
                icon: const Icon(Icons.logout))
            : null,
        actions: [
          IconButton(
            onPressed: () => ref.read(itemListFilterProvider.notifier).state =
                isObtainedFilter ? ItemListFilter.all : ItemListFilter.abtained,
            icon: Icon(isObtainedFilter
                ? Icons.check_circle
                : Icons.check_circle_outline),
          )
        ],
      ),
      body: const ItemList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => AddItemDialog.show(context, Item.empty()),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddItemDialog extends ConsumerWidget {
  get child => null;

  static void show(BuildContext context, Item item) {
    showDialog(
        context: context, builder: ((context) => AddItemDialog(item: item)));
  }

  final Item item;
  const AddItemDialog({Key? key, required this.item}) : super(key: key);

  bool get isUpdating => item.id != null;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textCotroller = TextEditingController(text: item.name);
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: textCotroller,
              autofocus: true,
              decoration: const InputDecoration(hintText: '商品名'),
            ),
            const SizedBox(
              height: 12.0,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  isUpdating
                      ? ref
                          .read(itemListControllerProvider.notifier)
                          .updateItem(
                            updatedItem: item.copyWith(
                                name: textCotroller.text.trim(), // trim()は空白を消す
                                obtained: item.obtained),
                          )
                      : ref.read(itemListControllerProvider.notifier).addItem(
                          name: textCotroller.text.trim()); // trim()は空白を消す
                  Navigator.of(context).pop();
                },
                child: Text(isUpdating ? '更新' : '追加'),
                style: ElevatedButton.styleFrom(
                    primary: isUpdating
                        ? Colors.orange
                        : Theme.of(context).primaryColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}

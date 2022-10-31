import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/controllers/item_list_controller.dart';
import 'package:riverpod_app/model/item_model.dart';
import 'package:riverpod_app/page/home_page.dart';

class itemTile extends ConsumerWidget {
  const itemTile({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      key: ValueKey(item.id),
      title: Text(item.name),
      trailing: Checkbox(
          value: item.obtained,
          onChanged: (value) => ref
              .read(itemListControllerProvider.notifier)
              .updateItem(
                  updatedItem: item.copyWith(obtained: !item.obtained))),
      onTap: () => AddItemDialog.show(context, item),
      onLongPress: () => ref
          .read(itemListControllerProvider.notifier)
          .deletedItem(itemId: item.id!),
    );
  }
}

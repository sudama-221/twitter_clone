import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/controllers/item_list_controller.dart';

class itemListError extends ConsumerWidget {
  final String message;
  const itemListError({super.key, required this.message});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: const TextStyle(fontSize: 20.0),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () => ref
                .read(itemListControllerProvider.notifier)
                .retrieveItem(isRefreshing: true),
            child: const Text('更新'),
          )
        ],
      ),
    );
  }
}

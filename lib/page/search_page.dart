import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone2/controller/user_controller.dart';
import 'package:twitter_clone2/widget/user_tile.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({
    Key? key,
    required this.currentUid,
  }) : super(key: key);
  final String currentUid;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  TextEditingController _searchController = TextEditingController();

  clearSearch(WidgetRef ref) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _searchController.clear());
    ref.read(userUpdateProvider.notifier).reset();
  }

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(userUpdateProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.5,
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 15),
              hintText: 'キーワード検索',
              hintStyle: const TextStyle(color: Colors.white),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
                onPressed: () {
                  clearSearch(ref);
                },
              ),
              filled: true),
          onChanged: (value) {
            if (value.isNotEmpty) {
              ref.read(userUpdateProvider.notifier).searchUser(value);
            }
          },
        ),
      ),
      // ignore: prefer_is_empty
      body: isUsers(users),
    );
  }
}

Widget isUsers(List? users) {
  print(users?.length);
  if (users == null) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.search,
            size: 200,
          ),
          Text(
            '検索してください',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  } else if (users.isEmpty) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.search,
            size: 200,
          ),
          Text(
            'ユーザーが見つかりません',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
  return ListView.builder(
      itemCount: users.length,
      itemBuilder: ((BuildContext context, int index) {
        return UserTile(
          user: users[index],
        );
      }));
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone2/controller/tweet_controller.dart';
import 'package:twitter_clone2/page/create_tweet.dart';
import 'package:twitter_clone2/page/notifications_page.dart';
import 'package:twitter_clone2/page/profile_page.dart';
import 'package:twitter_clone2/page/search_page.dart';
import 'package:twitter_clone2/page/timeline_page.dart';
import 'package:twitter_clone2/util/color.dart';

class FeedPage extends ConsumerStatefulWidget {
  const FeedPage(this.uid, {Key? key}) : super(key: key);
  final String uid;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FeedPageState();
}

class _FeedPageState extends ConsumerState<FeedPage> {
  int _selectedTab = 0;
  late String userId;
  @override
  void initState() {
    super.initState();
    userId = widget.uid;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _feedPages = [
      TimelinePage(
        currentUserId: userId,
      ),
      SearchPage(
        currentUid: userId,
      ),
      const NotificationsPage(),
      ProfilePage(
        uid: userId,
        currentUid: userId,
      )
    ];

    return Scaffold(
      body: _feedPages.elementAt(_selectedTab),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Image.asset('assets/img/tweet.png'),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CreateTweetPage()));
          ref.refresh(userTweetListProvider(userId));
        },
      ),
      bottomNavigationBar: CupertinoTabBar(
        onTap: (index) {
          setState(() {
            _selectedTab = index;
          });
        },
        currentIndex: _selectedTab,
        activeColor: mainColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}

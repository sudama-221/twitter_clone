import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone2/controller/auth_controller.dart';
import 'package:twitter_clone2/page/create_tweet.dart';
import 'package:twitter_clone2/page/notifications_page.dart';
import 'package:twitter_clone2/page/profile_page.dart';
import 'package:twitter_clone2/page/search_page.dart';
import 'package:twitter_clone2/page/test_page.dart';
import 'package:twitter_clone2/page/timeline_page.dart';
import 'package:twitter_clone2/test/container1_page.dart';
import 'package:twitter_clone2/test/container2_page.dart';
import 'package:twitter_clone2/util/color.dart';

// class FeedPage extends ConsumerStatefulWidget {
//   const FeedPage(this.uid, {Key? key}) : super(key: key);
//   final String uid;
//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _FeedPageState();
// }

// class _FeedPageState extends ConsumerState<FeedPage> {
//   @override
//   Widget build(BuildContext context) {
//     int _selectedTab = 0;
//     final List<Widget> _feedPages = [
//       const TimelinePage(),
//       const SearchPage(),
//       const NotificationsPage(),
//       const TestPage(),
//       const ProfilePage()
//     ];

//     return Scaffold(
//       body: _feedPages.elementAt(_selectedTab),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.white,
//         child: Image.asset('assets/img/tweet.png'),
//         onPressed: () {
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context) => const CreateTweetPage()));
//         },
//       ),
//       bottomNavigationBar: CupertinoTabBar(
//         onTap: (index) {
//           setState(() {
//             print(widget.uid);
//             print('Set');
//             _selectedTab = index;
//           });
//         },
//         currentIndex: _selectedTab,
//         activeColor: mainColor,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.notifications),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class TestFeedPage extends StatefulWidget {
//   const TestFeedPage({super.key});

//   @override
//   State<TestFeedPage> createState() => _TestFeedPageState();
// }

// class _TestFeedPageState extends State<TestFeedPage> {
//   @override
//   Widget build(BuildContext context) {
//     int _selectedTab = 0;
//     final List<Widget> _feedPages = [
//       const Container1(),
//       const Container2(),
//     ];

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('$_selectedTab'),
//       ),
//       body: _feedPages.elementAt(_selectedTab),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.white,
//         child: Image.asset('assets/img/tweet.png'),
//         onPressed: () {
//           setState(() {
//             print('ほれ $_selectedTab');
//             _selectedTab = _selectedTab + 1;
//           });
//           // Navigator.push(context,
//           //     MaterialPageRoute(builder: (context) => const CreateTweetPage()));
//         },
//       ),
//       bottomNavigationBar: CupertinoTabBar(
//         onTap: (index) {
//           setState(() {
//             print('Set');
//             _selectedTab = index;
//           });
//         },
//         currentIndex: _selectedTab,
//         activeColor: mainColor,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search),
//           ),
//         ],
//       ),
//     );
//   }
// }

class TestFeedPage extends StatefulWidget {
  // 使用するStateを指定

  final String uid;
  const TestFeedPage({super.key, required this.uid});
  @override
  _TestFeedPage createState() => _TestFeedPage();
}

// Stateを継承して使う
class _TestFeedPage extends State<TestFeedPage> {
  // データを宣言
  int count = 0;
  int _selectedTab = 0;

  late String userId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userId = widget.uid;
  }

  // データを元にWidgetを作る
  @override
  Widget build(BuildContext context) {
    final List<Widget> _feedPages = [
      const Container1(),
      ProfilePage(
        uid: userId,
        currentUid: userId,
      ),
      // const NotificationsPage(),
      // const TestPage(),
      // const ProfilePage()
    ];

    return Scaffold(
      body: _feedPages.elementAt(_selectedTab),
      bottomNavigationBar: CupertinoTabBar(
        onTap: (index) {
          setState(() {
            print('Set');
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
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.notifications),
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.person),
          // ),
        ],
      ),
    );
  }
}

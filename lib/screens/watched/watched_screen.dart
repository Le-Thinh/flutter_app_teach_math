import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_teach2/screens/auth/background.dart';
import 'package:flutter_app_teach2/screens/home/view/users/home_provider.dart';
import 'package:flutter_app_teach2/services/finished/finish_services.dart';
import 'package:flutter_app_teach2/services/watched/watch_service.dart';
import 'package:flutter_app_teach2/widget/finish_list.dart';
import 'package:flutter_app_teach2/widget/watched_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../services/auth/user_service.dart';
import '../../widget/nav_bottom.dart';
import '../auth/sign_in/sign_in_bloc/sign_in_bloc.dart';
import '../search/search_screen.dart';

class WatchedScreen extends StatefulWidget {
  const WatchedScreen({super.key});

  @override
  State<WatchedScreen> createState() => _WatchedScreenState();
}

class _WatchedScreenState extends State<WatchedScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  UserService userService = UserService();
  String nameUser = "Guest";
  String userId = "#########";
  WatchService watchService = WatchService();
  FinishServices finishServices = FinishServices();
  int _selectedIndex = 1;

  @override
  void initState() {
    userService.initUserName().then((value) {
      setState(() {
        nameUser = userService.getCurrentUserName;
      });
    });

    userService.initUserId().then((value) {
      setState(() {
        userId = userService.getCurrentUserId;
      });
    });

    super.initState();
  }

  void showSearchOverlay() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => FractionallySizedBox(
        heightFactor: 0.9,
        child: SearchOverlay(userId),
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to different screens based on the selected index
    switch (index) {
      case 0:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const HomeScreenProvider()));
        break;
      case 1:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const WatchedScreen()));
        break;
      case 2:
        // Navigate to School
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade50,
        title: Text(
          'Number Blocks',
          style: GoogleFonts.acme(
              textStyle: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w400,
          )),
        ),
        leading: ClipOval(
            child: Image.asset(
          'assets/images/logonumberblocks.jpg',
          fit: BoxFit.cover,
        )),
        actions: [
          IconButton(
            onPressed: () {
              showSearchOverlay();
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              _globalKey.currentState?.openDrawer();
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(64.0),
              child: GestureDetector(
                onTap: () {},
                child: ClipOval(
                  child: Image.asset(
                    "assets/images/logonumberblocks.jpg",
                    fit: BoxFit.cover,
                    scale: 5,
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text('Account: \r${nameUser}'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Video Watched'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Item 3'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Item 4'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Item 5'),
              onTap: () {},
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 34, 85, 139),
                    borderRadius: BorderRadius.circular(30.0)),
                child: TextButton(
                    onPressed: () {
                      context.read<SignInBloc>().add(SignOutRequired());
                    },
                    child: const Text(
                      "Đăng xuất",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    )),
              ),
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          const Background(),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                  child: Text(
                    "Diary",
                    style: GoogleFonts.acme(
                      textStyle: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SizedBox(
                    height: 100,
                    child: watchedPackList(userId, watchService),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16.0),
                  child: Text(
                    "Finished",
                    style: GoogleFonts.acme(
                      textStyle: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SizedBox(
                    height: 100,
                    child: finishedPackList(userId, finishServices),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: bottomNav(_selectedIndex, onItemTapped),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_teach2/screens/account/account_screen.dart';
import 'package:flutter_app_teach2/screens/auth/background.dart';
import 'package:flutter_app_teach2/screens/home/view/users/home_provider.dart';
import 'package:flutter_app_teach2/services/finished/finish_services.dart';
import 'package:flutter_app_teach2/services/watched/watch_service.dart';
import 'package:flutter_app_teach2/widget/draw.dart';
import 'package:flutter_app_teach2/widget/finish_list.dart';
import 'package:flutter_app_teach2/widget/watched_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../services/account/account_service.dart';
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
  AccountService accountService = AccountService();
  String? currentAvatar = "";

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
        getAvatarUser(userId);
      });
    });

    super.initState();
  }

  Future<void> getAvatarUser(String uid) async {
    await accountService.getAvatarUrl(uid);
    setState(() {
      currentAvatar = accountService.getCurrentAvatarUrl;
      ;
    });
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
        break;
      case 2:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AccountScreen(
                      userId: userId,
                    )));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      key: _globalKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Number Blocks',
          style: GoogleFonts.acme(
              textStyle: const TextStyle(
            fontSize: 24,
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
      drawer: DrawListView(context, currentAvatar, nameUser, userId),
      body: Stack(
        children: [
          // const Background(),
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
                        fontSize: 20,
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
                        fontSize: 20,
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

import 'package:flutter/material.dart';
import 'package:flutter_app_teach2/models/avatar/avatar.dart';
import 'package:flutter_app_teach2/repositories/avatar_repository.dart';
import 'package:flutter_app_teach2/screens/auth/background.dart';
import 'package:flutter_app_teach2/screens/editAvatar/edit_avatar_overlay.dart';
import 'package:flutter_app_teach2/services/account/account_service.dart';
import 'package:flutter_app_teach2/services/finished/finish_services.dart';
import 'package:flutter_app_teach2/services/watched/watch_service.dart';
import 'package:flutter_app_teach2/widget/count_lesson.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../services/auth/user_service.dart';
import '../../widget/nav_bottom.dart';
import '../auth/sign_in/sign_in_bloc/sign_in_bloc.dart';
import '../home/view/users/home_provider.dart';
import '../watched/watched_screen.dart';

class AccountScreen extends StatefulWidget {
  final String userId;

  AccountScreen({required this.userId, Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  UserService userService = UserService();
  FinishServices finishServices = FinishServices();
  WatchService watchService = WatchService();
  AccountService accountService = AccountService();
  AvatarRepository avatarRepository = AvatarRepository();
  Avatar avatar = Avatar.empty;
  String? currentAvatar = "";
  String nameUser = "Guest";
  int _selectedIndex = 2;
  int countLessonFinish = 0;
  int countLessWatched = 0;
  String? emailUser = "...@gmail.com";

  @override
  void initState() {
    super.initState();

    userService.initUserEmail().then((value) {
      setState(() {
        emailUser = userService.getCurrentUserEmail;
      });
    });

    accountService.getAvatarUrl(widget.userId).then((value) {
      setState(() {
        currentAvatar = accountService.getCurrentAvatarUrl ?? "";
      });
    });

    userService.initUserName().then((value) {
      setState(() {
        nameUser = userService.getCurrentUserName;
      });
    });

    finishServices.countLessonFinished(widget.userId).then((value) {
      setState(() {
        countLessonFinish = finishServices.getQuantityVideoFinish;
      });
    });

    watchService.countVideoWatched(widget.userId).then((value) {
      setState(() {
        countLessWatched = watchService.getQuantityVideoWatched;
      });
    });
  }

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

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
        break;
    }
  }

  void showEditAvatarOverlay() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => FractionallySizedBox(
        heightFactor: 0.95,
        child: EditAvatarOverlay(
          userId: widget.userId,
          onAvatarChanged: (avatar) {
            setState(() {
              currentAvatar = avatar;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade50,
        title: Text(
          'Account',
          style: GoogleFonts.acme(
            textStyle: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        leading: ClipOval(
          child: Image.asset(
            'assets/images/logonumberblocks.jpg',
            fit: BoxFit.cover,
          ),
        ),
        actions: [
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
              child: ClipOval(
                child: currentAvatar != null && currentAvatar!.isNotEmpty
                    ? Image.network(
                        currentAvatar!,
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        height: 100,
                        width: 100,
                        'assets/images/logonumberblocks.jpg',
                        scale: 1,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            ListTile(
              title: Text('Account: \r$nameUser'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Video Watched'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WatchedScreen()));
              },
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
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: TextButton(
                  onPressed: () {
                    context.read<SignInBloc>().add(SignOutRequired());
                  },
                  child: const Text(
                    "Đăng xuất",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                const Background(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Center(
                        child: Column(
                          children: [
                            ClipOval(
                              child: currentAvatar != null &&
                                      currentAvatar!.isNotEmpty
                                  ? Image.network(
                                      currentAvatar!,
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      height: 100,
                                      width: 100,
                                      'assets/images/logonumberblocks.jpg',
                                      scale: 1,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 96, 192, 151),
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: TextButton(
                                onPressed: showEditAvatarOverlay,
                                child: Text(
                                  "Edit Avatar",
                                  style: GoogleFonts.acme(
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LessonCountCard(
                            title: 'Lessons Finished',
                            count: countLessonFinish,
                          ),
                          LessonCountCard(
                            title: 'Lessons Watched',
                            count: countLessWatched,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 200,
                        child: ListView(
                          children: [
                            ListTile(
                              title: Text("Name: ${nameUser.toString()}"),
                            ),
                            ListTile(
                              title: Text("Email: ${emailUser.toString()}"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomNav(_selectedIndex, onItemTapped),
    );
  }
}

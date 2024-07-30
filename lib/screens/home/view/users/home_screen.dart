import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_teach2/repositories/view_repository.dart';
import 'package:flutter_app_teach2/screens/account/account_screen.dart';
import 'package:flutter_app_teach2/screens/auth/background.dart';
import 'package:flutter_app_teach2/screens/home/view/users/home_provider.dart';
import 'package:flutter_app_teach2/screens/watched/watched_provider.dart';
import 'package:flutter_app_teach2/screens/watched/watched_screen.dart';
import 'package:flutter_app_teach2/services/pack/pack_service.dart';
import 'package:flutter_app_teach2/widget/nav_bottom.dart';
import 'package:flutter_app_teach2/widget/outstanding_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_repository/user_repository.dart';
import '../../../../services/account/account_service.dart';
import '../../../../services/auth/user_service.dart';
import '../../../../widget/draw.dart';
import '../../../../widget/pack_list.dart';
import '../../../auth/sign_in/sign_in_bloc/sign_in_bloc.dart';
import '../../../../tile/pack_tile.dart';
import '../../../search/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  UserService userService = UserService();
  String nameUser = "Guest";
  String userId = "###############";
  late ViewRepository viewRepository;
  String? packId;
  Stream<QuerySnapshot>? packStream;
  PackService packService = PackService();
  AccountService accountService = AccountService();
  String? currentAvatar = "";
  List<PackTile> userPackList = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

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

    packService.getPackDataSort().then((stream) {
      setState(() {
        packStream = stream;
      });
    });

    viewRepository = ViewRepository();
  }

  Future<void> getAvatarUser(String uid) async {
    await accountService.getAvatarUrl(uid);
    setState(() {
      currentAvatar = accountService.getCurrentAvatarUrl;
      ;
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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AccountScreen(
                      userId: userId,
                    )));
        break;
    }
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
            textStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).textTheme.bodyText1?.color,
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
            onPressed: showSearchOverlay,
            icon: Icon(
              Icons.search,
              color: Theme.of(context).textTheme.bodyText1?.color,
            ),
          ),
          IconButton(
            onPressed: () {
              _globalKey.currentState?.openDrawer();
            },
            icon: Icon(
              Icons.person,
              color: Theme.of(context).textTheme.bodyText1?.color,
            ),
          ),
        ],
      ),
      drawer: DrawListView(context, currentAvatar as String, nameUser, userId),
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
                    "New Lesson",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyText1?.color,
                      ),
                    ),
                  ),
                ),
                packList(packStream),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    "Outstanding",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).textTheme.bodyText1?.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SizedBox(
                    height: 200,
                    child: outstandingPackList(viewRepository),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: bottomNav(_selectedIndex, onItemTapped),
    );
  }
}

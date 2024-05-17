import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_teach2/screens/auth/background.dart';
import 'package:flutter_app_teach2/services/pack/pack_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../services/auth/user_service.dart';
import '../../../widget/pack_list.dart';
import '../../auth/sign_in/sign_in_bloc/sign_in_bloc.dart';
import '../../tile/pack_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  late UserSevice userSevice = UserSevice();
  String nameUser = "Guest";

  String? packId;
  Stream<QuerySnapshot>? packStream;
  PackService packService = new PackService();
  List<PackTile> userPackList = [];

  @override
  void initState() {
    userSevice.initUserName().then((value) {
      setState(() {
        nameUser = userSevice.getCurrentUserName;
      });
    });

    packService.getPackData().then((stream) {
      setState(() {
        packStream = stream;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade50,
        title: Text(
          'Home',
          style: GoogleFonts.acme(),
        ),
        leading: ClipOval(
            child: Image.asset(
          'assets/images/logonumberblocks.jpg',
          fit: BoxFit.cover,
        )),
        actions: [
          IconButton(
              onPressed: () {
                _globalKey.currentState?.openDrawer();
              },
              icon: const Icon(Icons.person))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(64.0),
              child: ClipOval(
                child: Image.asset(
                  "assets/images/logonumberblocks.jpg",
                  fit: BoxFit.cover,
                  scale: 5,
                ),
              ),
            ),
            ListTile(
              title: Text('Thông tin tài khoản: \r${nameUser}'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Các khóa học'),
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
          Background(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                child: Text(
                  "Mới Nhất",
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: packList(packStream, userPackList),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_teach2/screens/auth/background.dart';
import 'package:flutter_app_teach2/screens/createPack/view/create_pack_.dart';
import 'package:flutter_app_teach2/screens/createPack/view/create_pack_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pack_repository/pack_repository.dart';

import '../../../../services/auth/user_service.dart';
import '../../../auth/sign_in/sign_in_bloc/sign_in_bloc.dart';

class TeacherScreen extends StatefulWidget {
  TeacherScreen({super.key});

  @override
  State<TeacherScreen> createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  UserSevice userSevice = UserSevice();
  String nameUser = "Guest";

  @override
  void initState() {
    super.initState();
    userSevice.initUserName().then((value) {
      setState(() {
        nameUser = userSevice.getCurrentUserName;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade50,
        title: Text(
          'Teacher Home',
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
            Image.asset(
              "assets/images/logo.png",
              scale: 4,
            ),
            ListTile(
              title: Text('Thông tin tài khoản: \r${nameUser}'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Lớp học của bạn'),
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
        ],
      ),
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 62, 194, 255),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const CreatePackProvider()));
          },
          icon: const Icon(Icons.add),
          color: Colors.black,
        ),
      ),
    );
  }
}

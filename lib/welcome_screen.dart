import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_teach2/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_app_teach2/screens/auth/background.dart';
import 'package:flutter_app_teach2/screens/auth/sign_in/sign_in_bloc/sign_in_bloc.dart';
import 'package:flutter_app_teach2/screens/auth/sign_in/view/sign_in_provider.dart';
import 'package:flutter_app_teach2/screens/auth/sign_in/view/sign_in_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_repository/user_repository.dart';

import 'screens/auth/sign_up/view/sign_up_provider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  late UserRepository userRepository;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade50,
        leading: Image.asset('assets/images/logo.png'),
        title: Text(
          'Math',
          style: GoogleFonts.acme(
              textStyle: const TextStyle(color: Colors.blue, fontSize: 32)),
        ),
        actions: [
          IconButton(
              onPressed: () {
                _globalKey.currentState?.openDrawer();
              },
              icon: const Icon(Icons.menu))
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
              title: const Text('Item 1'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Item 2'),
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
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SignInProvider()));
                  },
                  child: const Text(
                    "Đăng nhập",
                    style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 34, 85, 139),
                        fontWeight: FontWeight.w500),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 34, 85, 139),
                    borderRadius: BorderRadius.circular(30.0)),
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SignUpProvider()));
                    },
                    child: const Text(
                      "Đăng ký",
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
    );
  }
}

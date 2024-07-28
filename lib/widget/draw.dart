import 'package:flutter/material.dart';
import 'package:flutter_app_teach2/screens/account/account_screen.dart';
import 'package:flutter_app_teach2/screens/notifications/view/notification_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/auth/sign_in/sign_in_bloc/sign_in_bloc.dart';
import '../screens/watched/watched_screen.dart';

Widget DrawListView(BuildContext context, String? currentAvatar,
    String nameUser, String userId) {
  return Drawer(
    child: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(64.0),
          child: ClipOval(
            child: currentAvatar != null && currentAvatar.isNotEmpty
                ? Image.network(
                    currentAvatar,
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/images/logonumberblocks.jpg',
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        ListTile(
          title: Text('Account: \r$nameUser'),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AccountScreen(userId: userId)));
          },
        ),
        ListTile(
          title: const Text('Library'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const WatchedScreen()));
          },
        ),
        ListTile(
          title: const Text('Notifications'),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationScreen()));
          },
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
  );
}

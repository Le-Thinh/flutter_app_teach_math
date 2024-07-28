import 'package:flutter/material.dart';
import 'package:flutter_app_teach2/screens/auth/sign_in/sign_in_bloc/sign_in_bloc.dart';
import 'package:flutter_app_teach2/screens/home/view/admin/home_admin.dart';
import 'package:flutter_app_teach2/screens/home/view/users/home_bloc/home_bloc.dart';
import 'package:flutter_app_teach2/screens/home/view/users/home_provider.dart';
import 'package:flutter_app_teach2/screens/home/view/teacher/home_teacher.dart';
import 'package:flutter_app_teach2/screens/notifications/view/notification_screen.dart';
import 'package:flutter_app_teach2/screens/watched/watched_screen.dart';
import 'package:flutter_app_teach2/welcome_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

import 'blocs/authentication_bloc/authentication_bloc.dart';
import 'repositories/view_repository.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class MyAppView extends StatelessWidget {
  final UserRepository _userRepository;
  const MyAppView(this._userRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AuthenticationBloc(userRepository: _userRepository),
        ),
        BlocProvider(
          create: (context) =>
              SignInBloc(context.read<AuthenticationBloc>().userRepository),
        ),
        BlocProvider(
          create: (context) => HomeBloc(ViewRepository()),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: "Math",
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state.status == AuthenticationStatus.unauthenticated) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                (route) => false,
              );
            }
          },
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state.status == AuthenticationStatus.authenticated) {
                final email = state.user!.email;
                if (email.contains("ad")) {
                  return const AdminScreen();
                } else if (email.contains("gv")) {
                  return TeacherScreen();
                } else {
                  return const HomeScreenProvider();
                }
              } else {
                return const WelcomeScreen();
              }
            },
          ),
        ),
        routes: {
          '/watched': (context) => const WatchedScreen(),
          '/home': (context) => const HomeScreenProvider(),
          '/teacherHome': (context) => TeacherScreen(),
          '/notification_screen': (context) => const NotificationScreen(),
        },
      ),
    );
  }
}

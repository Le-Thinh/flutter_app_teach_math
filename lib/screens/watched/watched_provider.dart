import 'package:flutter/material.dart';
import 'package:flutter_app_teach2/screens/auth/sign_in/sign_in_bloc/sign_in_bloc.dart';
import 'package:flutter_app_teach2/screens/watched/watched_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class WatchedProvider extends StatelessWidget {
  UserRepository _userRepository;
  WatchedProvider(this._userRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInBloc(_userRepository),
      child: const WatchedScreen(),
    );
  }
}

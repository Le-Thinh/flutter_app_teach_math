import 'package:flutter/cupertino.dart';
import 'package:flutter_app_teach2/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_app_teach2/screens/auth/sign_in/sign_in_bloc/sign_in_bloc.dart';
import 'package:flutter_app_teach2/screens/auth/sign_up/sign_up_bloc/sign_up_bloc.dart';
import 'package:flutter_app_teach2/screens/home/view/users/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sign_up_screen.dart';

class SignUpProvider extends StatelessWidget {
  const SignUpProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state.status == AuthenticationStatus.authenticated) {
          return BlocProvider<SignInBloc>(
            create: (_) =>
                SignInBloc(context.read<AuthenticationBloc>().userRepository),
            child: const HomeScreen(),
          );
        } else {
          return BlocProvider<SignUpBloc>(
            create: (_) =>
                SignUpBloc(context.read<AuthenticationBloc>().userRepository),
            child: const SignUpScreen(),
          );
        }
      },
    );
  }
}

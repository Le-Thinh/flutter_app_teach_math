import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_teach2/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_app_teach2/screens/auth/sign_in/sign_in_bloc/sign_in_bloc.dart';
import 'package:flutter_app_teach2/screens/auth/sign_in/view/sign_in_screen.dart';
import 'package:flutter_app_teach2/screens/home/view/admin/home_admin.dart';
import 'package:flutter_app_teach2/screens/home/view/teacher/home_teacher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/view/home_screen.dart';

class SignInProvider extends StatelessWidget {
  const SignInProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state.status == AuthenticationStatus.authenticated) {
          final email = state.user!.email;
          if (email.contains("ad")) {
            return BlocProvider(
              create: (context) =>
                  SignInBloc(context.read<AuthenticationBloc>().userRepository),
              child: const AdminScreen(),
            );
          } else if (email.contains("gv")) {
            return BlocProvider(
              create: (context) =>
                  SignInBloc(context.read<AuthenticationBloc>().userRepository),
              child: TeacherScreen(),
            );
          } else {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => SignInBloc(
                      context.read<AuthenticationBloc>().userRepository),
                ),
              ],
              child: const HomeScreen(),
            );
          }
        } else {
          return BlocProvider<SignInBloc>(
            create: (_) =>
                SignInBloc(context.read<AuthenticationBloc>().userRepository),
            child: SignInScreen(),
          );
        }
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_app_teach2/repositories/view_repository.dart';
import 'package:flutter_app_teach2/screens/home/view/users/home_bloc/home_bloc.dart';
import 'package:flutter_app_teach2/screens/home/view/users/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenProvider extends StatelessWidget {
  const HomeScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(ViewRepository()),
      child: const HomeScreen(),
    );
  }
}

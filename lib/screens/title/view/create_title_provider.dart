import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_teach2/repositories/tile_repository.dart';
import 'package:flutter_app_teach2/screens/title/title_bloc/title_bloc.dart';
import 'package:flutter_app_teach2/screens/title/view/create_title_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTitleProvider extends StatelessWidget {
  const CreateTitleProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TitleBloc>(
      create: (context) => TitleBloc(
        TitleRepository(),
      ),
      child: const CreateTitleScreen(),
    );
  }
}

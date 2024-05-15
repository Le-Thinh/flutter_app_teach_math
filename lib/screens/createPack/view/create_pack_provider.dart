import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_teach2/screens/createPack/create_pack_bloc/createpack_bloc.dart';
import 'package:flutter_app_teach2/screens/createPack/view/create_pack_.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pack_repository/pack_repository.dart';

class CreatePackProvider extends StatelessWidget {
  const CreatePackProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreatepackBloc>(
      create: (context) => CreatepackBloc(FirebasePackRepo()),
      child: const CreatePackScreen(),
    );
  }
}

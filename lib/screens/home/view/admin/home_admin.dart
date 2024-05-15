import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../auth/sign_in/sign_in_bloc/sign_in_bloc.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin',
          style: GoogleFonts.acme(),
        ),
        leading: Image.asset('assets/images/logo.png'),
        actions: [
          IconButton(
              onPressed: () {
                context.read<SignInBloc>().add(SignOutRequired());
              },
              icon: const Icon(Icons.person))
        ],
      ),
    );
  }
}

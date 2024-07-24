import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_teach2/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_app_teach2/screens/auth/background.dart';
import 'package:flutter_app_teach2/screens/auth/sign_up/view/sign_up_provider.dart';
import 'package:flutter_app_teach2/screens/home/view/users/home_screen.dart';
import 'package:flutter_app_teach2/welcome_screen.dart';
import 'package:flutter_app_teach2/widget/my_text_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../sign_in_bloc/sign_in_bloc.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool signInRequired = false;
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool obscurePassword = true;
  String? _errorMsg;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is SignInSuccess) {
          setState(() {
            signInRequired = false;
          });
        } else if (state is SignInProcess) {
          setState(() {
            signInRequired = true;
          });
        } else if (state is SignInFailure) {
          setState(() {
            signInRequired = false;
            _errorMsg = 'Invalid email or password';
          });
        }
      },
      child: Form(
        key: _formKey,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue.shade50,
              leading: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => WelcomeScreen()));
                  },
                  child: ClipOval(
                      child: Image.asset(
                    'assets/images/logonumberblocks.jpg',
                    fit: BoxFit.cover,
                  ))),
              title: Text(
                'NumberBlocks',
                style: GoogleFonts.acme(
                    textStyle:
                        const TextStyle(color: Colors.blue, fontSize: 32)),
              ),
            ),
            body: Stack(
              children: <Widget>[
                const Background(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: MyTextField(
                          controller: emailController,
                          hintText: 'email',
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: const Icon(CupertinoIcons.mail_solid),
                          errorMsg: _errorMsg,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Please fill in this field';
                            } else if (!RegExp(
                                    r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$')
                                .hasMatch(val)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: MyTextField(
                        controller: passwordController,
                        hintText: 'password',
                        obscureText: obscurePassword,
                        keyboardType: TextInputType.visiblePassword,
                        prefixIcon: const Icon(CupertinoIcons.lock_fill),
                        errorMsg: _errorMsg,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please fill in this field';
                          } else if (!RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$')
                              .hasMatch(val)) {
                            return 'Please enter a valid password';
                          }
                          return null;
                        },
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                              if (obscurePassword) {
                                iconPassword = CupertinoIcons.eye_fill;
                              } else {
                                iconPassword = CupertinoIcons.eye_slash_fill;
                              }
                            });
                          },
                          icon: Icon(iconPassword),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    !signInRequired
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: TextButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // ignore: unused_local_variable
                                    String email = emailController.text;
                                    // ignore: unused_local_variable
                                    String password = passwordController.text;
                                    context.read<SignInBloc>().add(
                                        SignInRequired(emailController.text,
                                            passwordController.text));
                                    MultiBlocProvider(
                                      providers: [
                                        BlocProvider(
                                          create: (context) => SignInBloc(
                                              context
                                                  .read<AuthenticationBloc>()
                                                  .userRepository),
                                        ),
                                      ],
                                      child: const HomeScreen(),
                                    );
                                  }
                                },
                                style: TextButton.styleFrom(
                                    elevation: 3.0,
                                    backgroundColor:
                                        const Color.fromARGB(255, 83, 146, 198),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(60))),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 5),
                                  child: Text(
                                    'Sign In',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )),
                          )
                        : const CircularProgressIndicator(),
                    const SizedBox(height: 16),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account yet?"),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => SignUpProvider()));
                              },
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 14),
                              )),
                        ],
                      ),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}

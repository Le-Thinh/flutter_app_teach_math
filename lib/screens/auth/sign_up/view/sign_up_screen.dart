import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_teach2/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_app_teach2/screens/auth/background.dart';
import 'package:flutter_app_teach2/screens/auth/sign_up/sign_up_bloc/sign_up_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_repository/user_repository.dart';

import '../../../../welcome_screen.dart';
import '../../../../widget/my_text_view.dart';
import '../../sign_in/view/sign_in_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool obscurePassword = true;
  bool signUpRequired = false;

  bool containsUpperCase = false;
  bool containsLowerCase = false;
  bool containsNumber = false;
  bool containsSpecialChar = false;
  bool contains8Length = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          setState(() {
            signUpRequired = false;
          });
        } else if (state is SignUpProcess) {
          setState(() {
            signUpRequired = true;
          });
        } else if (state is SignUpFailure) {
          return;
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
                      builder: (context) => const WelcomeScreen()));
                },
                child: Image.asset('assets/images/logo.png')),
            title: Text(
              'Math',
              style: GoogleFonts.acme(
                  textStyle: const TextStyle(color: Colors.blue, fontSize: 32)),
            ),
          ),
          body: Stack(
            children: <Widget>[
              Background(),
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
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please fill in this field';
                          } else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$')
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
                        hintText: 'Password',
                        obscureText: obscurePassword,
                        keyboardType: TextInputType.visiblePassword,
                        prefixIcon: const Icon(CupertinoIcons.lock_fill),
                        onChanged: (val) {
                          if (val!.contains(RegExp(r'[A-Z]'))) {
                            setState(() {
                              containsUpperCase = true;
                            });
                          } else {
                            setState(() {
                              containsUpperCase = false;
                            });
                          }
                          if (val.contains(RegExp(r'[a-z]'))) {
                            setState(() {
                              containsLowerCase = true;
                            });
                          } else {
                            setState(() {
                              containsLowerCase = false;
                            });
                          }
                          if (val.contains(RegExp(r'[0-9]'))) {
                            setState(() {
                              containsNumber = true;
                            });
                          } else {
                            setState(() {
                              containsNumber = false;
                            });
                          }
                          if (val.contains(RegExp(
                              r'^(?=.*?[!@#$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^])'))) {
                            setState(() {
                              containsSpecialChar = true;
                            });
                          } else {
                            setState(() {
                              containsSpecialChar = false;
                            });
                          }
                          if (val.length >= 8) {
                            setState(() {
                              contains8Length = true;
                            });
                          } else {
                            setState(() {
                              contains8Length = false;
                            });
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
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please fill in this field';
                          } else if (!RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$')
                              .hasMatch(val)) {
                            return 'Please enter a valid password';
                          }
                          return null;
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "⚈  1 uppercase",
                            style: TextStyle(
                                color: containsUpperCase
                                    ? Colors.green
                                    : Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                          ),
                          Text(
                            "⚈  1 lowercase",
                            style: TextStyle(
                                color: containsLowerCase
                                    ? Colors.green
                                    : Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                          ),
                          Text(
                            "⚈  1 number",
                            style: TextStyle(
                                color: containsNumber
                                    ? Colors.green
                                    : Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "⚈  1 special character",
                            style: TextStyle(
                                color: containsSpecialChar
                                    ? Colors.green
                                    : Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                          ),
                          Text(
                            "⚈  8 minimum character",
                            style: TextStyle(
                                color: contains8Length
                                    ? Colors.green
                                    : Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: MyTextField(
                        controller: nameController,
                        hintText: 'Name',
                        obscureText: false,
                        keyboardType: TextInputType.name,
                        prefixIcon: const Icon(CupertinoIcons.person_fill),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please fill in this field';
                          } else if (val.length > 30) {
                            return 'Name too long';
                          }
                          return null;
                        }),
                  ),
                  SizedBox(height: 10),
                  !signUpRequired
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: TextButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  MyUser myUser = MyUser.empty;
                                  myUser.email = emailController.text;
                                  myUser.name = nameController.text;
                                  myUser.role = '1';
                                  myUser.active = true;

                                  setState(() {
                                    context.read<SignUpBloc>().add(
                                        SignUpRequired(
                                            myUser, passwordController.text));
                                    context.read<AuthenticationUserChanged>();
                                  });
                                }
                              },
                              style: TextButton.styleFrom(
                                  elevation: 3.0,
                                  backgroundColor:
                                      const Color.fromARGB(255, 83, 146, 198),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(60))),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 5),
                                child: Text(
                                  'Sign Up',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              )),
                        )
                      : const CircularProgressIndicator(),
                  SizedBox(height: 10),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account yet?"),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => const SignInProvider()));
                            },
                            child: const Text(
                              'Sign In',
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
          ),
        ),
      ),
    );
  }
}

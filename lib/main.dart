import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_teach2/api/firebase_api.dart';
import 'package:flutter_app_teach2/app.dart';
import 'package:flutter_app_teach2/firebase_options.dart';
import 'package:flutter_app_teach2/simple_bloc_observer.dart';
import 'package:user_repository/user_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
  runApp(MyApp(FirebaseUserRepo()));
}

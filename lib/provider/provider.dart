import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UiProvider extends ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;

  late SharedPreferences storage;

  //Custom dark theme
  final darkTheme = ThemeData(
    primaryColor: Colors.black12,
    brightness: Brightness.dark,
    backgroundColor: Colors.black,
    shadowColor: Colors.white24,
    cardColor: Colors.grey[800],
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: Colors.white),
      bodyText2: TextStyle(color: Colors.white70),
      subtitle1: TextStyle(color: Colors.black54),
      subtitle2: TextStyle(color: Colors.black87),
    ),
  );

  //Custom light theme
  final lightTheme = ThemeData(
    primaryColor: Colors.white,
    brightness: Brightness.light,
    backgroundColor: Colors.white,
    cardColor: Colors.white,
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: Colors.black),
      bodyText2: TextStyle(color: Colors.black87),
      subtitle1: TextStyle(color: Colors.white70),
      subtitle2: TextStyle(color: Colors.white60),
    ),
  );

  changeTheme() {
    _isDark = !_isDark;
    print('Dark: $_isDark');

    //Save the value to secure storage
    storage.setBool('isDark', _isDark);
    notifyListeners();
  }

  init() async {
    storage = await SharedPreferences.getInstance();
    _isDark = storage.getBool('isDark') ?? false;
    notifyListeners();
  }
}

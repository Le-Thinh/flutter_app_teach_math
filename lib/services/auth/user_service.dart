import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app_teach2/services/auth/user_repo.dart';

class UserService implements UserServiceRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final collection = FirebaseFirestore.instance.collection('users');
  String _userName = "Guest";
  String _userId = "???????????";
  String _email = "....@gmail.com";
  DateTime? _joinDay;

  @override
  String get getCurrentUserName => _userName;

  Future<void> initUserName() async {
    try {
      User? user = _firebaseAuth.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await collection.doc(user.uid).get();
        if (userDoc.exists) {
          _userName = userDoc['name'] ?? 'Guest';
        }
      }
    } catch (e) {
      print("Error: ${e.toString()}");
    }
  }

  @override
  String get getCurrentUserId => _userId;

  Future<void> initUserId() async {
    try {
      User? user = _firebaseAuth.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await collection.doc(user.uid).get();
        if (userDoc.exists) {
          _userId = userDoc['userId'] ?? "???????";
        }
      }
    } catch (e) {
      print("Error: ${e.toString()}");
    }
  }

  @override
  String get getCurrentUserEmail => _email;
  Future<void> initUserEmail() async {
    try {
      User? user = _firebaseAuth.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await collection.doc(user.uid).get();
        if (userDoc.exists) {
          _email = userDoc['email'] ?? "....@gmail.com";
        }
      }
    } catch (e) {
      print("Error: ${e.toString()}");
    }
  }

  @override
  DateTime? get getCurrentUserJoinDay => _joinDay;
  Future<void> initJoinDay() async {
    try {
      User? user = _firebaseAuth.currentUser;

      if (user != null) {
        final creationTime = user.metadata.creationTime;
        if (creationTime != null) {
          _joinDay =
              DateTime(creationTime.year, creationTime.month, creationTime.day);
        } else {
          _joinDay = null;
        }
      }
    } catch (e) {
      print("Error: ${e.toString()}");
    }
  }
}

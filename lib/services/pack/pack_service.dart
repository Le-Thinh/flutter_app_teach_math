import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PackService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final collection = FirebaseFirestore.instance.collection('packes');
  String _lessonName = "???????";
  String _title = "?????????";
  String _videoUrl = "##";
  String _description = "";

  getPackData() async {
    try {
      return await collection.snapshots();
    } catch (e) {
      print("Error get packdata: " + e.toString());
    }
  }

  getPackDataSort() async {
    try {
      return await collection.orderBy('createAt', descending: true).snapshots();
    } catch (e) {
      print("Error get packdata: " + e.toString());
    }
  }

  getPackDataDetailByID(String packId) async {
    try {
      return collection.doc(packId).snapshots();
    } catch (e) {
      print("Error when get pack detail by Id: " + e.toString());
    }
  }

  getPackDataSameTitle(String packId) async {
    String? title;
    try {
      DocumentSnapshot packDoc = await collection.doc(packId).get();
      if (packDoc.exists) {
        title = packDoc["title"] ?? "??????????";
      }
      return collection.where('title', isEqualTo: title.toString()).snapshots();
    } catch (e) {
      print("Error when get pack same title: " + e.toString());
    }
  }

  String get getLessonName => _lessonName;

  Future<void> getLessonNameById(String packId) async {
    try {
      DocumentSnapshot packDoc = await collection.doc(packId).get();
      if (packDoc.exists) {
        _lessonName = packDoc["lessonName"] ?? "??????????";
      }
    } catch (e) {
      print("Error get lesson Name By Id: " + e.toString());
    }
  }

  String get getTitle => _title;
  Future<void> getTitleById(String packId) async {
    try {
      DocumentSnapshot packDoc = await collection.doc(packId).get();
      if (packDoc.exists) {
        _title = packDoc["title"] ?? "??????????";
      }
    } catch (e) {
      print("Error get title: " + e.toString());
    }
  }

  String get videoUrl => _videoUrl;
  Future<void> getVideoUrlById(String packId) async {
    try {
      DocumentSnapshot packDoc = await collection.doc(packId).get();
      if (packDoc.exists) {
        _videoUrl = packDoc["video"] ?? "??????????";
      }
    } catch (e) {
      print("Error get videoUrl: " + e.toString());
    }
  }

  String get description => _description;
  Future<void> getDescriptionById(String packId) async {
    try {
      DocumentSnapshot packDoc = await collection.doc(packId).get();
      if (packDoc.exists) {
        _description = packDoc["description"] ?? "??????";
      }
    } catch (e) {
      print("Error get description by Id: " + e.toString());
    }
  }
}

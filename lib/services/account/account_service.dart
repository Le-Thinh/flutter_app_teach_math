import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_app_teach2/services/account/account_repo.dart';
import 'package:intl/intl.dart';

class AccountService extends AccountRepository {
  final _watchedCollection = FirebaseFirestore.instance.collection('watched');
  final _finishedCollection = FirebaseFirestore.instance.collection('finished');
  final _firebaseAuth = FirebaseAuth.instance.currentUser;
  final _avatarCollection = FirebaseFirestore.instance.collection('avatars');
  final _infoCollection = FirebaseFirestore.instance.collection('infos');
  final _userCollection = FirebaseFirestore.instance.collection('users');

  String _avatarUrl = "";
  String? _address = '';
  String? _phone = '';
  DateTime? _birthday;

  Future<String?> uploadImage() async {
    try {
      final uid = _firebaseAuth?.uid;
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null) {
        File file = File(result.files.single.path!);
        String filePath =
            '$uid/avatar/${DateTime.now().millisecondsSinceEpoch}_${file.uri.pathSegments.last}';
        TaskSnapshot uploadTask =
            await FirebaseStorage.instance.ref(filePath).putFile(file);
        return await uploadTask.ref.getDownloadURL();
      }
    } catch (e) {
      print("Error uploading image: $e");
    }
    return null;
  }

  @override
  String get getCurrentAvatarUrl => _avatarUrl;

  Future<void> getAvatarUrl(String uid) async {
    try {
      DocumentSnapshot avaDoc = await _avatarCollection.doc(uid).get();
      if (avaDoc.exists && avaDoc.data() != null) {
        var data = avaDoc.data() as Map<String, dynamic>;
        _avatarUrl = data['avatar'] ?? "";
      } else {
        _avatarUrl = "";
      }
    } catch (e) {
      print("Error getting avatar URL: ${e.toString()}");
      _avatarUrl = "";
    }
  }

  @override
  String? get getCurrentUserAddress => _address;
  Future<void> getAddress(String uid) async {
    try {
      DocumentSnapshot infoDoc = await _infoCollection.doc(uid).get();
      if (infoDoc.exists && infoDoc.data() != null) {
        var data = infoDoc.data() as Map<String, dynamic>;
        _address = data['address'] ?? '';
      } else {
        _address = '';
      }
    } catch (e) {
      print("Error getting address user ${e.toString()}");
      _address = '';
    }
  }

  @override
  DateTime? get getCurrentUserBirthday => _birthday;
  Future<void> getBirthDay(String uid) async {
    try {
      DocumentSnapshot infoDoc = await _infoCollection.doc(uid).get();
      if (infoDoc.exists && infoDoc.data() != null) {
        var data = infoDoc.data() as Map<String, dynamic>;
        var dateOfBirth = data['dateOfBirth'];

        if (dateOfBirth is Timestamp) {
          _birthday = dateOfBirth.toDate();
        } else if (dateOfBirth is String) {
          _birthday = DateTime.parse(dateOfBirth);
        } else {
          _birthday = DateTime(2000, 1, 1);
        }
      } else {
        _birthday = DateTime(2000, 1, 1);
      }
    } catch (e) {
      print("Error getting birthday user ${e.toString()}");
      _birthday = DateTime(2000, 1, 1);
    }
  }

  @override
  String? get getCurrentUserPhone => _phone;
  Future<void> getPhone(String uid) async {
    try {
      DocumentSnapshot infoDoc = await _infoCollection.doc(uid).get();
      if (infoDoc.exists && infoDoc.data() != null) {
        var data = infoDoc.data() as Map<String, dynamic>;
        _phone = data['phone'] ?? '';
      } else {
        _phone = '';
      }
    } catch (e) {
      print("Error get phone user ${e.toString()}");
    }
  }

  Future<void> updateName(String uid, String name) async {
    try {
      _userCollection.doc(uid).update({
        'name': name,
      });
    } catch (e) {
      print("Error update name user ${e.toString()}");
    }
  }
}

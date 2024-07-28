import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_app_teach2/services/account/account_repo.dart';

class AccountService extends AccountRepository {
  final _watchedCollection = FirebaseFirestore.instance.collection('watched');
  final _finishedCollection = FirebaseFirestore.instance.collection('finished');
  final _firebaseAuth = FirebaseAuth.instance.currentUser;
  final _avatarCollection = FirebaseFirestore.instance.collection('avatars');

  String _avatarUrl = "";

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
  }

  @override
  String get getCurrentAvatarUrl => _avatarUrl;

  Future<void> getAvatarUrl(String uid) async {
    try {
      DocumentSnapshot avaDoc = await _avatarCollection.doc(uid).get();
      if (avaDoc.exists && avaDoc.data() != null) {
        var data = avaDoc.data() as Map<String, dynamic>;
        _avatarUrl =
            data['avatar'] ?? ""; // Provide a default value if 'avatar' is null
      } else {
        _avatarUrl = ""; // Provide a default value if document does not exist
      }
    } catch (e) {
      print("Error getting avatar URL: ${e.toString()}");
      _avatarUrl = ""; // Provide a default value in case of an error
    }
  }
}

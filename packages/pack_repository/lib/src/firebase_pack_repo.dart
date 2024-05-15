import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pack_repository/src/models/pack.dart';

class FirebasePackRepo {
  final _firebaseAuth = FirebaseAuth.instance.currentUser;

  final packesCollection = FirebaseFirestore.instance.collection('packes');

  // TODO: implement pack
  Stream<Pack?> get pack => throw UnimplementedError();

  Future<String?> uploadVideo(/*File file*/) async {
    try {
      final userId = _firebaseAuth?.uid;
      final storageRef = FirebaseStorage.instance.ref();
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.video);
      if (result != null) {
        File file = File(result.files.single.path!);

        String filePath =
            '$userId/video/${DateTime.now().millisecondsSinceEpoch}_${file.uri.pathSegments.last}';
        TaskSnapshot uploadTask =
            await FirebaseStorage.instance.ref(filePath).putFile(file);
        return await uploadTask.ref
            .getDownloadURL(); // Directly returning the download URL
      }
    } catch (e) {
      print("Error uploading video: $e");
    }
    return null; // Return null if picking is cancelled or fails
  }

  // Future<bool> pickFileVideo(File file) async {
  //   final useId = _firebaseAuth?.uid;
  //   final storageRef = FirebaseStorage.instance.ref();

  // }

  Future<String?> uploadImage() async {
    try {
      final uid = _firebaseAuth?.uid;
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null) {
        File file = File(result.files.single.path!);
        String filePath =
            '$uid/image/${DateTime.now().millisecondsSinceEpoch}_${file.uri.pathSegments.last}';
        TaskSnapshot uploadTask =
            await FirebaseStorage.instance.ref(filePath).putFile(file);
        return await uploadTask.ref.getDownloadURL();
      }
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  Future<String?> selectFile() async {
    try {
      final uid = _firebaseAuth?.uid;
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null) {
        File file = File(result.files.single.path!);
        String filePath =
            '$uid/image/${DateTime.now().millisecondsSinceEpoch}_${file.uri.pathSegments.last}';
        TaskSnapshot uploadTask =
            await FirebaseStorage.instance.ref(filePath).putFile(file);
        return await uploadTask.ref.getDownloadURL();
      }
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  Future<void> createPack(Pack mypack) async {
    try {
      DocumentReference packDoc =
          await packesCollection.add(mypack.toEntity().toDocument());

      mypack.packid = packDoc.id;
      await packesCollection
          .doc(mypack.packid)
          .update({'packId': mypack.packid});
      print("Pack created with ID: ${mypack.packid}");
    } catch (e) {
      print("Error creating pack: " + e.toString());
      rethrow;
    }
  }
}

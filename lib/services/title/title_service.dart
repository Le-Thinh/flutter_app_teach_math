import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TitleService {
  final _firebaseAuth = FirebaseAuth.instance.currentUser;
  final _titleCollection = FirebaseFirestore.instance.collection("titles");

  getTitles() async {
    try {
      return await _titleCollection.snapshots();
    } catch (e) {
      print("Error fetching titles: $e");
      return [];
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TitleService {
  final _firebaseAuth = FirebaseAuth.instance.currentUser;
  final _titleCollection = FirebaseFirestore.instance.collection("titles");

  Future<List<DocumentSnapshot>> getTitlesByCurrentUser() async {
    try {
      QuerySnapshot querySnapshot = await _titleCollection
          .where('userId', isEqualTo: _firebaseAuth!.uid)
          .get();
      return querySnapshot.docs;
    } catch (e) {
      print("Error fetching titles: $e");
      return [];
    }
  }
}

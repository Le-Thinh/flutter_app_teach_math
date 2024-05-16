import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PackService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final collection = FirebaseFirestore.instance.collection('packes');

  getPackData() async {
    try {
      return await collection.snapshots();
    } catch (e) {
      print("Error get packdata: " + e.toString());
    }
  }
}

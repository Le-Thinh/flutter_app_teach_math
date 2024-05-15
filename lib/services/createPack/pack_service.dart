import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PackService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final collection = FirebaseFirestore.instance.collection('packes');
}

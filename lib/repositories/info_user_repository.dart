import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_teach2/models/account_info/info.dart';

class InfoUserRepository {
  final _infoCollection = FirebaseFirestore.instance.collection('infos');

  Future<void> setDataInfoUser(Info info) async {
    try {
      await _infoCollection.doc(info.userId).set(info.toEntity().toDocument());
    } catch (e) {
      print("Set Data Info User Error: ${e.toString()}");
    }
  }
}

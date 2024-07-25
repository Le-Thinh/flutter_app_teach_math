import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_teach2/models/finished/finish.dart';

class FinishRepository {
  final _finishCollection = FirebaseFirestore.instance.collection('finished');

  Future<void> setDataFinish(Finish finish) async {
    try {
      await _finishCollection
          .doc(finish.userId)
          .collection('videoFinish')
          .doc(finish.packId)
          .set(finish.toEntity().toDocument());

      await _finishCollection.doc(finish.userId).set({'userId': finish.userId});
    } catch (e) {
      print("Set Data Finish Error: " + e.toString());
    }
  }
}

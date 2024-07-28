import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_teach2/services/finished/finish_repo.dart';

class FinishServices extends FinishServiceRepository {
  final _finishCollection = FirebaseFirestore.instance.collection('finished');
  final _packedCollection = FirebaseFirestore.instance.collection('packes');
  int quantityVideoFinish = 0;

  Stream<List<Map<String, dynamic>>> getPackFinished(String userId) {
    return _finishCollection
        .doc(userId)
        .collection('videoFinish')
        .orderBy('finishAt', descending: true)
        .snapshots()
        .asyncMap((snapshot) async {
      List<Map<String, dynamic>> packList = [];
      for (var doc in snapshot.docs) {
        DocumentSnapshot packDoc = await _packedCollection.doc(doc.id).get();
        Map<String, dynamic>? packData =
            packDoc.data() as Map<String, dynamic>?;

        if (packData != null) {
          packList.add({
            'packId': doc.id,
            'img': packData['img'],
            'title': packData['title'],
            'lessonName': packData['lessonName'],
          });
        }
      }
      return packList.toList();
    });
  }

  @override
  int get getQuantityVideoFinish => quantityVideoFinish;

  Future<int?> countLessonFinished(String userId) async {
    try {
      QuerySnapshot doc =
          await _finishCollection.doc(userId).collection('videoFinish').get();

      return quantityVideoFinish = doc.size;
    } catch (e) {
      print("Error count lesson finish ${e.toString()}");
    }
  }
}

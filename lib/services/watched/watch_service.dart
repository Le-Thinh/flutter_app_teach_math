import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_teach2/services/watched/watch_repo.dart';

class WatchService extends WatchedServiceRepository {
  final _watchedCollection = FirebaseFirestore.instance.collection('watched');
  final _packedCollection = FirebaseFirestore.instance.collection('packes');
  int _quantityVideoWatched = 0;

  Stream<List<Map<String, dynamic>>> getPackWatched(String userId) {
    return _watchedCollection
        .doc(userId)
        .collection('video')
        .orderBy('watchAt', descending: true)
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
  int get getQuantityVideoWatched => _quantityVideoWatched;

  Future<int?> countVideoWatched(String userId) async {
    try {
      QuerySnapshot doc =
          await _watchedCollection.doc(userId).collection('video').get();

      return _quantityVideoWatched = doc.size;
    } catch (e) {
      print('Error count video watched ${e.toString()}');
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_teach2/models/watched/watch.dart';

import '../models/view/view.dart';

class ViewRepository {
  final _viewCollection = FirebaseFirestore.instance.collection('views');
  final _watchedCollection = FirebaseFirestore.instance.collection('watched');
  final _packCollection = FirebaseFirestore.instance.collection('packes');

  Future<void> setDataView(Views view, String packId) async {
    try {
      DocumentReference viewDoc = await _viewCollection
          .doc(packId)
          .collection('viewers')
          .add(view.toEntity().toDocument());
      view.viewId = viewDoc.id;
      await _viewCollection
          .doc(packId)
          .collection('viewers')
          .doc(view.viewId)
          .update({'viewId': view.viewId});
      await _viewCollection.doc(packId).set({
        'packId': packId,
      });
      print("View Created with ID: ${view.viewId}");
    } catch (e) {
      print("Error view: " + e.toString());
    }
  }

  Future<void> setDataWatched(Watch watch) async {
    try {
      await _watchedCollection
          .doc(watch.userId)
          .collection('video')
          .doc(watch.packId)
          .set(watch.toEntity().toDocument());

      await _watchedCollection.doc(watch.userId).set({'userId': watch.userId});
    } catch (e) {
      print("Error watched: " + e.toString());
    }
  }

  Future<int> countViewers(String packId) async {
    try {
      QuerySnapshot querySnapshot =
          await _viewCollection.doc(packId).collection('viewers').get();

      return querySnapshot.size;
    } catch (e) {
      print("Error counting viewers: " + e.toString());
      return 0;
    }
  }

  Stream<List<Map<String, dynamic>>> getTopPacks(int limit) {
    return _viewCollection.snapshots().asyncMap((snapshot) async {
      List<Map<String, dynamic>> packList = [];

      for (var doc in snapshot.docs) {
        String packId = doc.id;
        int count = await countViewers(packId);

        DocumentSnapshot packDoc = await _packCollection.doc(packId).get();
        Map<String, dynamic>? packData =
            packDoc.data() as Map<String, dynamic>?;

        if (packData != null) {
          packList.add({
            'packId': packId,
            'viewCount': count,
            'img': packData['img'],
            'title': packData['title'],
            'lessonName': packData['lessonName'],
          });
        }
      }

      packList.sort((a, b) => b['viewCount'].compareTo(a['viewCount']));

      return packList.take(limit).toList();
    });
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app_teach2/models/title/model.dart';

class TitleRepository {
  final _titleCollection = FirebaseFirestore.instance.collection('titles');

  Future<void> setDataTitle(title title) async {
    try {
      DocumentReference titleDoc =
          await _titleCollection.add(title.toEntity().toDocument());

      title.titleId = titleDoc.id;
      await _titleCollection
          .doc(title.titleId)
          .update({'titleId': title.titleId});
      print("Title Created with ID: ${title.titleId}");
    } catch (e) {
      print("Error creating title: " + e.toString());
    }
  }
}

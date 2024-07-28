import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/avatar/model.dart';

class AvatarRepository {
  final avatarCollection = FirebaseFirestore.instance.collection('avatars');

  Future<void> setDataAvatar(Avatar avatar) {
    return avatarCollection
        .doc(avatar.userId)
        .set(avatar.toEntity().toDocument());
  }
}

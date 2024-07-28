import 'package:flutter_app_teach2/models/avatar/entity.dart';

class Avatar {
  String userId;
  String? avatar;
  DateTime? updateAt;

  Avatar({
    required this.userId,
    this.avatar,
    required this.updateAt,
  });

  static final empty = Avatar(
    userId: '',
    avatar: '',
    updateAt: null,
  );

  AvatarEntity toEntity() {
    return AvatarEntity(
      userId: userId,
      avatar: avatar as String,
      updateAt: updateAt as DateTime,
    );
  }

  static Avatar fromEntity(AvatarEntity entity) {
    return Avatar(
      userId: entity.userId,
      avatar: entity.avatar,
      updateAt: entity.updateAt,
    );
  }
}

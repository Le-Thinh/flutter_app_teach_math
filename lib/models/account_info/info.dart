import 'package:flutter_app_teach2/models/account_info/entity.dart';

class Info {
  String userId;
  String name;
  String email;
  DateTime? updateAt;
  String avatar;
  Info({
    required this.userId,
    required this.name,
    required this.email,
    required this.updateAt,
    required this.avatar,
  });

  static final empty = Info(
    userId: '',
    name: '',
    email: '',
    updateAt: null,
    avatar: '',
  );

  InfoEntity toEntity() {
    return InfoEntity(
      userId: userId,
      name: name,
      email: email,
      updateAt: updateAt as DateTime,
      avatar: avatar,
    );
  }

  static Info fromEntity(InfoEntity entity) {
    return Info(
      userId: entity.userId,
      name: entity.name,
      email: entity.email,
      updateAt: entity.updateAt,
      avatar: entity.avatar,
    );
  }
}

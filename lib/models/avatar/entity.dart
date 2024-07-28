class AvatarEntity {
  String userId;
  String? avatar;
  DateTime? updateAt;

  AvatarEntity({
    required this.userId,
    this.avatar,
    required this.updateAt,
  });

  Map<String, Object?> toDocument() {
    return {
      'userId': userId,
      'avatar': avatar as String,
      'updateAt': updateAt as DateTime,
    };
  }

  static AvatarEntity fromDocument(Map<String, dynamic> doc) {
    return AvatarEntity(
      userId: doc['userId'],
      avatar: doc['avatar'],
      updateAt: doc['updateAt'],
    );
  }
}

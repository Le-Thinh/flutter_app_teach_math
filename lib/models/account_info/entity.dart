class InfoEntity {
  String userId;
  String name;
  String email;
  DateTime? updateAt;
  String avatar;
  InfoEntity({
    required this.userId,
    required this.name,
    required this.email,
    required this.updateAt,
    required this.avatar,
  });

  Map<String, Object?> toDocument() {
    return {
      "userId": userId,
      "name": name,
      "email": email,
      "updateAt": updateAt as DateTime,
      "avatar": avatar
    };
  }

  static InfoEntity fromDocument(Map<String, dynamic> doc) {
    return InfoEntity(
      userId: doc['userId'],
      name: doc['name'],
      email: doc['email'],
      updateAt: doc['updateAt'],
      avatar: doc['avatar'],
    );
  }
}

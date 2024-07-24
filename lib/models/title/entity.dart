class TitleEntity {
  String titleId;
  String titleName;
  String titleCreateBy;
  DateTime? titleCreateAt;
  String titleDescription;

  TitleEntity({
    required this.titleId,
    required this.titleName,
    required this.titleCreateBy,
    required this.titleCreateAt,
    required this.titleDescription,
  });

  Map<String, Object?> toDocument() {
    return {
      'titleId': titleId,
      'titleName': titleName,
      'createBy': titleCreateBy,
      'createAt': titleCreateAt as DateTime,
      'description': titleDescription,
    };
  }

  static TitleEntity fromDocument(Map<String, dynamic> doc) {
    return TitleEntity(
      titleId: doc['titleId'],
      titleName: doc['titleName'],
      titleCreateBy: doc['createBy'],
      titleCreateAt: doc['createAt'],
      titleDescription: doc['description'],
    );
  }
}

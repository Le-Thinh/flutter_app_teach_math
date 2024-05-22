class MyPackEntity {
  String packid;
  String lessonName;
  String title;
  String video;
  String img;
  DateTime? createAt;
  String createBy;
  String description;

  MyPackEntity({
    required this.packid,
    required this.lessonName,
    required this.title,
    required this.video,
    required this.img,
    required this.createAt,
    required this.createBy,
    this.description = '',
  });

  Map<String, Object?> toDocument() {
    return {
      'packId': packid,
      'lessonName': lessonName,
      'title': title,
      'video': video,
      'img': img,
      'createAt': createAt as DateTime,
      'createBy': createBy,
      'description': description,
    };
  }

  static MyPackEntity fromDocument(Map<String, dynamic> doc) {
    return MyPackEntity(
        packid: doc['packid'],
        lessonName: doc['lessonName'],
        title: doc['title'],
        video: doc['video'],
        img: doc['img'],
        createAt: doc['createAt'],
        createBy: doc['createBy'],
        description: doc['description']);
  }
}

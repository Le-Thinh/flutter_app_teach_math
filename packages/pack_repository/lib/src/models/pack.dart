import 'package:pack_repository/src/entities/entities.dart';
import 'package:pack_repository/src/entities/pack_entity.dart';

class Pack {
  String packid;
  String lessonName;
  String thumnail;
  String video;
  String img;
  DateTime? createAt;
  String createBy;
  String description;

  Pack({
    required this.packid,
    required this.lessonName,
    required this.thumnail,
    required this.video,
    required this.img,
    required this.createAt,
    required this.createBy,
    this.description = '',
  });

  static final empty = Pack(
    packid: '',
    lessonName: '',
    thumnail: '',
    video: '',
    img: '',
    createAt: null,
    createBy: '',
    description: '',
  );

  MyPackEntity toEntity() {
    return MyPackEntity(
      packid: packid,
      lessonName: lessonName,
      thumnail: thumnail,
      video: video,
      img: img,
      createAt: createAt,
      createBy: createBy,
      description: description,
    );
  }

  static Pack fromEntity(MyPackEntity entity) {
    return Pack(
        packid: entity.packid,
        lessonName: entity.lessonName,
        thumnail: entity.thumnail,
        video: entity.video,
        img: entity.img,
        createAt: entity.createAt,
        createBy: entity.createBy,
        description: entity.description);
  }

  @override
  String toString() {
    return 'My Pack: $packid, $lessonName, $thumnail, $video, $img, $createAt, $createBy, $description';
  }
}

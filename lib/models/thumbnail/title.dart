import 'package:flutter_app_teach2/models/thumbnail/entity.dart';

class title {
  String titleId;
  String titleName;
  String titleCreateBy;
  DateTime? titleCreateAt;
  String titleDescription;

  title({
    required this.titleId,
    required this.titleName,
    required this.titleCreateBy,
    required this.titleCreateAt,
    required this.titleDescription,
  });

  static final empty = title(
    titleId: '',
    titleName: '',
    titleCreateBy: '',
    titleCreateAt: null,
    titleDescription: '',
  );

  TitleEntity toEntity() {
    return TitleEntity(
        titleId: titleId,
        titleName: titleName,
        titleCreateBy: titleCreateBy,
        titleCreateAt: titleCreateAt,
        titleDescription: titleDescription);
  }

  static title fromEntity(TitleEntity entity) {
    return title(
      titleId: entity.titleId,
      titleName: entity.titleName,
      titleCreateBy: entity.titleCreateBy,
      titleCreateAt: entity.titleCreateAt,
      titleDescription: entity.titleDescription,
    );
  }
}

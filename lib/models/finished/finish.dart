import 'package:flutter_app_teach2/models/finished/entity.dart';

class Finish {
  String userId;
  String packId;
  DateTime? finishAt;

  Finish({
    required this.userId,
    required this.packId,
    required this.finishAt,
  });

  static final empty = Finish(
    userId: '',
    packId: '',
    finishAt: null,
  );

  FinishEntity toEntity() {
    return FinishEntity(
      userId: userId,
      packId: packId,
      finishAt: finishAt as DateTime,
    );
  }

  static Finish fromEntity(FinishEntity entity) {
    return Finish(
      userId: entity.userId,
      packId: entity.packId,
      finishAt: entity.finishAt,
    );
  }
}

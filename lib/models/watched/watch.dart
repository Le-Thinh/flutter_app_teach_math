import 'package:flutter_app_teach2/models/watched/entity.dart';

class Watch {
  String userId;
  String packId;
  DateTime? watchAt;

  Watch({
    required this.userId,
    required this.packId,
    required this.watchAt,
  });

  static final empty = Watch(
    userId: '',
    packId: '',
    watchAt: null,
  );

  WatchEntity toEntity() {
    return WatchEntity(
      userId: userId,
      packId: packId,
      watchAt: watchAt,
    );
  }

  static Watch fromEntity(WatchEntity entity) {
    return Watch(
      userId: entity.userId,
      packId: entity.packId,
      watchAt: entity.watchAt,
    );
  }
}

import 'package:flutter_app_teach2/models/view/entity.dart';

class Views {
  String viewId;
  String viewerId;
  String packId;
  DateTime? viewAt;
  bool? finish;

  Views({
    required this.viewId,
    required this.viewerId,
    required this.packId,
    required this.viewAt,
    required this.finish,
  });

  static final empty = Views(
    viewId: '',
    viewerId: '',
    packId: '',
    viewAt: null,
    finish: false,
  );

  ViewEntity toEntity() {
    return ViewEntity(
      viewId: viewId,
      viewerId: viewerId,
      packId: packId,
      viewAt: viewAt,
      finish: finish,
    );
  }

  static Views fromEntity(ViewEntity entity) {
    return Views(
      viewId: entity.viewId,
      viewerId: entity.viewerId,
      packId: entity.packId,
      viewAt: entity.viewAt,
      finish: entity.finish,
    );
  }
}

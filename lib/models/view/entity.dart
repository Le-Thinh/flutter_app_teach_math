class ViewEntity {
  String viewId;
  String viewerId;
  String packId;
  DateTime? viewAt;

  ViewEntity({
    required this.viewId,
    required this.viewerId,
    required this.packId,
    required this.viewAt,
  });

  Map<String, Object?> toDocument() {
    return {
      'viewId': viewId,
      'viewerId': viewerId,
      'packId': packId,
      'viewAt': viewAt as DateTime,
    };
  }

  static ViewEntity fromDocument(Map<String, dynamic> doc) {
    return ViewEntity(
      viewId: doc['viewId'],
      viewerId: doc['viewerId'],
      packId: doc['packId'],
      viewAt: doc['viewAt'],
    );
  }
}

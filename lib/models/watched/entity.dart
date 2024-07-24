class WatchEntity {
  String userId;
  String packId;
  DateTime? watchAt;

  WatchEntity({
    required this.userId,
    required this.packId,
    required this.watchAt,
  });

  Map<String, Object?> toDocument() {
    return {
      'userId': userId,
      'packId': packId,
      'watchAt': watchAt,
    };
  }

  static WatchEntity fromDocument(Map<String, dynamic> doc) {
    return WatchEntity(
      userId: doc['userId'],
      packId: doc['packId'],
      watchAt: doc['watchAt'],
    );
  }
}

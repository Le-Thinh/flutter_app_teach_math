class FinishEntity {
  String userId;
  String packId;
  DateTime? finishAt;

  FinishEntity({
    required this.userId,
    required this.packId,
    required this.finishAt,
  });

  Map<String, Object?> toDocument() {
    return {
      'userId': userId,
      'packId': packId,
      'finishAt': finishAt as DateTime,
    };
  }

  static FinishEntity fromDocument(Map<String, dynamic> doc) {
    return FinishEntity(
      userId: doc['userId'],
      packId: doc['packId'],
      finishAt: doc['finishAt'],
    );
  }
}

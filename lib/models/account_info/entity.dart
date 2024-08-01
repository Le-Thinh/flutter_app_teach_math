class InfoEntity {
  String userId;
  String email;
  String name;
  String? phone;
  String? address;
  DateTime? dateOfBirth;
  DateTime? lastUpdateAt;
  DateTime? lastLoginAt;
  InfoEntity({
    required this.userId,
    required this.email,
    required this.name,
    required this.phone,
    required this.address,
    required this.dateOfBirth,
    required this.lastUpdateAt,
    required this.lastLoginAt,
  });

  Map<String, Object?> toDocument() {
    return {
      "userId": userId,
      "name": name,
      "email": email,
      "phone": phone,
      "address": address,
      "dateOfBirth": dateOfBirth as DateTime,
      "lastUpdateAt": lastUpdateAt as DateTime,
      "lastLoginAt": lastLoginAt as DateTime,
    };
  }

  static InfoEntity fromDocument(Map<String, dynamic> doc) {
    return InfoEntity(
      userId: doc['userId'],
      name: doc['name'],
      email: doc['email'],
      phone: doc['phone'],
      address: doc['address'],
      dateOfBirth: doc['dateOfBirth'],
      lastUpdateAt: doc['lastUpdateAt'],
      lastLoginAt: doc['lastLoginAt'],
    );
  }
}

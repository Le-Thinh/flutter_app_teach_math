import 'package:flutter_app_teach2/models/account_info/entity.dart';

class Info {
  String userId;
  String email;
  String name;
  String? phone;
  String? address;
  DateTime? dateOfBirth;
  DateTime? lastUpdateAt;
  DateTime? lastLoginAt;

  Info({
    required this.userId,
    required this.email,
    required this.name,
    required this.phone,
    required this.address,
    required this.dateOfBirth,
    required this.lastUpdateAt,
    required this.lastLoginAt,
  });

  static final empty = Info(
    userId: '',
    name: '',
    email: '',
    phone: '',
    address: '',
    dateOfBirth: null,
    lastUpdateAt: null,
    lastLoginAt: null,
  );

  InfoEntity toEntity() {
    return InfoEntity(
      userId: userId,
      name: name,
      email: email,
      phone: phone,
      address: address,
      dateOfBirth: dateOfBirth,
      lastUpdateAt: lastUpdateAt as DateTime,
      lastLoginAt: lastLoginAt as DateTime,
    );
  }

  static Info fromEntity(InfoEntity entity) {
    return Info(
      userId: entity.userId,
      name: entity.name,
      email: entity.email,
      phone: entity.phone,
      address: entity.address,
      dateOfBirth: entity.dateOfBirth,
      lastUpdateAt: entity.lastUpdateAt,
      lastLoginAt: entity.lastLoginAt,
    );
  }
}

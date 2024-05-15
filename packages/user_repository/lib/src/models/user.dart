import '../entities/user_entity.dart';

class MyUser {
  String userId;
  String email;
  String name;
  String role;
  bool active;

  MyUser({
    required this.userId,
    required this.email,
    required this.name,
    required this.role,
    required this.active,
  });

  static final empty = MyUser(
    userId: '',
    email: '',
    name: '',
    role: '',
    active: false,
  );

  MyUserEntity toEntity() {
    return MyUserEntity(
      userId: userId,
      email: email,
      name: name,
      role: role,
      active: active,
    );
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      userId: entity.userId,
      email: entity.email,
      name: entity.name,
      role: entity.role,
      active: entity.active,
    );
  }

  @override
  String toString() {
    return 'MyUser: $userId, $email, $name, $role, $active';
  }
}

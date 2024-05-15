import 'models/models.dart';

abstract class UserRepository {
  Stream<MyUser?> get user;

  Future<MyUser> signUp(MyUser myUser, String password);

  Future<void> signIn(String email, String password);

  Future<void> logOut();

  Future<void> setUserData(MyUser myUser);
}

import 'package:clean_arch/src/modules/post/domain/entities/user.dart';

class UserAdapter {
  static User fromJson(dynamic data) {
    return User(
      id: data['id'],
      name: data['name'],
      photo: data['avatar']['url'],
    );
  }
}

import 'package:clean_arch/src/modules/post/domain/entities/post.dart';

import 'user_adapter.dart';

class PostAdapter {
  PostAdapter._();

  static Post fromJson(dynamic data) {
    return Post(
      id: data['id'],
      text: data['text'],
      totalComments: data['totalComments'],
      user: UserAdapter.fromJson(data['user']),
    );
  }
}

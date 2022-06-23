import '../../domain/entities/comment.dart';

class CommentAdapter {
  static Comment fromJson(dynamic data) {
    return Comment(
      id: data['id'],
      text: data['text'],
    );
  }
}

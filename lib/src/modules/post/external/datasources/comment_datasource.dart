import 'package:uno/uno.dart';

import '../../domain/errors/errors.dart';
import '../../infra/datasources/comment_datasource.dart';

class CommentDatasource implements ICommentDatasource {
  final Uno uno;

  CommentDatasource(this.uno);

  @override
  Future<List> getComments() async {
    try {
      final response = await uno.get('http://localhost:3031/comments');

      return response.data;
    } catch (e, s) {
      throw DatasourcePostException(e.toString(), s);
    }
  }
}

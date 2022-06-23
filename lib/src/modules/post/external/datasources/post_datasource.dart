import 'package:uno/uno.dart';

import '../../domain/errors/errors.dart';
import '../../infra/datasources/post_datasource.dart';

class PostDatasource implements IPostDatasource {
  final Uno uno;

  PostDatasource(this.uno);

  @override
  Future<List> getPosts() async {
    try {
      final response = await uno.get('http://localhost:3031/posts');

      return response.data;
    } catch (e, s) {
      throw DatasourcePostException(e.toString(), s);
    }
  }
}

import 'package:uno/uno.dart';

import '../../domain/errors/errors.dart';
import '../../infra/datasources/user_datasource.dart';

class UserDatasource implements IUserDatasource {
  final Uno uno;

  UserDatasource(this.uno);

  @override
  Future<List> getUsers() async {
    try {
      final response = await uno.get('http://localhost:3031/users');

      return response.data;
    } catch (e, s) {
      throw DatasourcePostException(e.toString(), s);
    }
  }
}

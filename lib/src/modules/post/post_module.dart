import 'package:flutter_modular/flutter_modular.dart';
import 'package:uno/uno.dart';

import 'domain/repositories/post_repository.dart';
import 'domain/usecases/get_post_comments.dart';
import 'domain/usecases/get_posts.dart';
import 'external/datasources/comment_datasource.dart';
import 'external/datasources/post_datasource.dart';
import 'external/datasources/user_datasource.dart';
import 'infra/datasources/comment_datasource.dart';
import 'infra/datasources/post_datasource.dart';
import 'infra/datasources/user_datasource.dart';
import 'infra/repositories/post_repository.dart';
import 'presenter/pages/post_page.dart';
import 'presenter/stores/post_store.dart';

class PostModule extends Module {
  @override
  List<Bind> get binds => [
        //utils
        Bind.factory((i) => Uno()),
        //datasource
        Bind.factory<IUserDatasource>((i) => UserDatasource(i())),
        Bind.factory<IPostDatasource>((i) => PostDatasource(i())),
        Bind.factory<ICommentDatasource>((i) => CommentDatasource(i())),
        //repository
        Bind.factory<IPostRepository>((i) => PostRepository(i(), i(), i())),
        //usecase
        Bind.factory((i) => GetPosts(i())),
        Bind.factory((i) => GetPostComments(i())),
        //store
        Bind.singleton((i) => PostStore(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const PostPage()),
      ];
}

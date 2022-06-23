import 'package:clean_arch/src/modules/post/domain/entities/comment.dart';
import 'package:clean_arch/src/modules/post/domain/entities/post.dart';
import 'package:clean_arch/src/modules/post/domain/errors/errors.dart';
import 'package:clean_arch/src/modules/post/infra/adapters/comment_adapter.dart';
import 'package:clean_arch/src/modules/post/infra/adapters/post_adapter.dart';
import 'package:clean_arch/src/modules/post/infra/datasources/user_datasource.dart';
import 'package:fpdart/src/either.dart';

import '../../domain/repositories/post_repository.dart';
import '../datasources/comment_datasource.dart';
import '../datasources/post_datasource.dart';

class PostRepository extends IPostRepository {
  final IUserDatasource userDatasource;
  final IPostDatasource postDatasource;
  final ICommentDatasource commentDatasource;

  PostRepository(this.userDatasource, this.postDatasource, this.commentDatasource);

  @override
  Future<Either<IPostException, List<Comment>>> getPostComments(String postId) async {
    try {
      final list = await commentDatasource.getComments();

      final comments = list
          .where(
            (element) => element['postId'] == postId,
          )
          .map(CommentAdapter.fromJson)
          .toList();

      return right(comments);
    } on IPostException catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<IPostException, List<Post>>> getPosts() async {
    try {
      final listComments = await commentDatasource.getComments();
      final listUsers = await userDatasource.getUsers();
      final listPosts = await postDatasource.getPosts();

      final map = <String, int>{};

      for (var comment in listComments) {
        if (!map.containsKey(comment['postId'])) {
          map[comment['postId']] = 1;
        } else {
          map[comment['postId']] = map[comment['postId']]! + 1;
        }
      }

      for (var user in listUsers) {
        for (var post in listPosts) {
          if (user['id'] == post['userId']) {
            post['user'] = user;
          }

          post['totalComments'] = map[post['id']] ?? 0;
        }
      }

      final posts = listPosts.map(PostAdapter.fromJson).toList();

      return right(posts);
    } on IPostException catch (e) {
      return left(e);
    }
  }
}

import 'package:clean_arch/src/modules/post/domain/entities/comment.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/post.dart';
import '../errors/errors.dart';

abstract class IPostRepository {
  Future<Either<IPostException, List<Post>>> getPosts();
  Future<Either<IPostException, List<Comment>>> getPostComments(
    String postId,
  );
}

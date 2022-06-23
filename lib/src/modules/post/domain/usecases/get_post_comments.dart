import 'package:clean_arch/src/modules/post/domain/entities/comment.dart';
import 'package:fpdart/fpdart.dart';

import '../errors/errors.dart';
import '../repositories/post_repository.dart';

abstract class IGetPostComments {
  Future<Either<IPostException, List<Comment>>> call(String postId);
}

class GetPostComments implements IGetPostComments {
  final IPostRepository repository;
  GetPostComments(this.repository);

  @override
  Future<Either<IPostException, List<Comment>>> call(String postId) async {
    if (postId.isEmpty) {
      return left(const ArgumentsException('postId is empty'));
    }

    return await repository.getPostComments(postId);
  }
}

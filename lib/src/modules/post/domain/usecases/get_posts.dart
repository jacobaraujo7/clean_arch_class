import 'package:fpdart/fpdart.dart';

import '../entities/post.dart';
import '../errors/errors.dart';
import '../repositories/post_repository.dart';

abstract class IGetPosts {
  Future<Either<IPostException, List<Post>>> call();
}

class GetPosts implements IGetPosts {
  final IPostRepository repository;

  GetPosts(this.repository);

  @override
  Future<Either<IPostException, List<Post>>> call() async {
    return await repository.getPosts();
  }
}

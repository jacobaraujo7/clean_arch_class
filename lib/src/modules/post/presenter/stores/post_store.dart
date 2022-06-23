import 'package:clean_arch/src/modules/post/presenter/states/post_state.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/usecases/get_posts.dart';

class PostStore extends ValueNotifier<PostState> {
  final IGetPosts getPosts;

  PostStore(this.getPosts) : super(EmptyPostState());

  void emit(PostState newState) => value = newState;

  Future<void> fetchPosts() async {
    emit(LoadingPostState());

    final result = await getPosts.call();

    final newState = result.fold((l) {
      return ErrorPostState(l.message);
    }, (r) {
      return SuccessPostState(r);
    });

    emit(newState);
  }
}

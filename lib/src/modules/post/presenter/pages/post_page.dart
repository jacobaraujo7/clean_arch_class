import 'package:clean_arch/src/modules/post/presenter/states/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../domain/entities/post.dart';
import '../stores/post_store.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  void initState() {
    super.initState();
    context.read<PostStore>().fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<PostStore>();
    final state = store.value;

    Widget child = Container();

    if (state is LoadingPostState) {
      child = const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state is ErrorPostState) {
      child = Center(
        child: Text(state.message),
      );
    }

    if (state is SuccessPostState) {
      child = ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 30),
        itemCount: state.posts.length,
        itemBuilder: (context, index) {
          final post = state.posts[index];
          return PostCard(
            post: post,
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Post'),
      ),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: child,
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  final Post post;
  const PostCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                ClipOval(
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.network(post.user.photo, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(width: 20),
                Text(post.user.name),
              ],
            ),
            Text(post.text),
            const SizedBox(height: 8),
            TextButton(
              onPressed: post.totalComments > 0 ? () {} : null,
              child: Text(
                'COMMENT(${post.totalComments})',
              ),
            )
          ],
        ),
      ),
    );
  }
}

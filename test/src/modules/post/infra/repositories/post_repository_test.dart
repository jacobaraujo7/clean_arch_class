import 'dart:convert';

import 'package:clean_arch/src/modules/post/domain/entities/comment.dart';
import 'package:clean_arch/src/modules/post/domain/entities/post.dart';
import 'package:clean_arch/src/modules/post/infra/datasources/comment_datasource.dart';
import 'package:clean_arch/src/modules/post/infra/datasources/post_datasource.dart';
import 'package:clean_arch/src/modules/post/infra/datasources/user_datasource.dart';
import 'package:clean_arch/src/modules/post/infra/repositories/post_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class UserDatasourceMock extends Mock implements UserDatasource {}

class PostDatasourceMock extends Mock implements PostDatasource {}

class CommentDatasourceMock extends Mock implements CommentDatasource {}

void main() {
  final UserDatasource userDatasource = UserDatasourceMock();
  final PostDatasource postDatasource = PostDatasourceMock();
  final CommentDatasource commentDatasource = CommentDatasourceMock();

  final repository = PostRepository(userDatasource, postDatasource, commentDatasource);

  test('get posts', () async {
    when(() => userDatasource.getUsers()).thenAnswer((_) async => usersJson);
    when(() => postDatasource.getPosts()).thenAnswer((_) async => postJson);
    when(() => commentDatasource.getComments()).thenAnswer((_) async => commentJson);

    final result = await repository.getPosts();

    final list = result.fold(id, id);
    expect(list, isA<List<Post>>());
    expect((list as List).length, 3);
    expect((list as List<Post>).first.id, '0');
    expect((list).first.totalComments, 3);
  });
  test('get comment', () async {
    when(() => commentDatasource.getComments()).thenAnswer((_) async => commentJson);

    final result = await repository.getPostComments('0');

    final list = result.fold(id, id);
    expect(list, isA<List<Comment>>());
    expect((list as List).length, 3);
  });
}

final usersJson = jsonDecode(
    r''' 
[
	{
		"id": "0",
		"name": "Robert",
		"avatar": {
			"url": "https://static1.conquistesuavida.com.br/articles//4/56/84/@/18399-as-pessoas-sensiveis-tem-por-caracteris-article_gallery_large-3.jpg"
		}
	},
	{
		"id": "1",
		"name": "Carls",
		"avatar": {
			"url": "https://www.familia.com.br/wp-content/uploads/2019/12/Pessoas-felizes-n%C3%A3o-t%C3%AAm-tempo-para-criticar-a-vida-dos-outros.jpg"
		}
	}
]

''');
final commentJson = jsonDecode(
    r''' 
[
	{
		"id": "0",
		"postId": "0",
		"text": "Hello"
	},
	{
		"id": "1",
		"postId": "0",
		"text": "Hi"
	},
	{
		"id": "2",
		"postId": "0",
		"text": "Hi!"
	},
	{
		"id": "3",
		"postId": "1",
		"text": "Hi"
	},
	{
		"id": "4",
		"postId": "1",
		"text": "Hi!"
	}
]

''');
final postJson = jsonDecode(
    r''' 
[
	{
		"id": "0",
		"userId": "0",
		"text": "Coisas legais sobre o Flutter que devemos saber mas a gente não sabe pq tem preguiça de estudar"
	},
	{
		"id": "1",
		"userId": "1",
		"text": "Coisas legais sobre o Flutter que devemos saber mas a gente não sabe pq tem preguiça de estudar"
	},
	{
		"id": "2",
		"userId": "0",
		"text": "Eu sinceramente não gosto de android studio, por favor, utilizem o VSCode, OBRIGADO!"
	}
]
''');

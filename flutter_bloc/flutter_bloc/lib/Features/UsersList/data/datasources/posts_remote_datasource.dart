import 'package:flutter_bloc_demo/core/errors/exceptions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/post_model.dart';

abstract class PostsRemoteDataSource {
  /// Calls the http://jsonplaceholder.com/users endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<PostModel>> getListPosts();
  Future<PostModel> getPost(int postId);
}

class PostsRemoteDataSourceImpl implements PostsRemoteDataSource {
  final http.Client client;

  static const _baseUrl = 'jsonplaceholder.typicode.com';
  static const _GET_POSTS = '/posts';

  PostsRemoteDataSourceImpl({required this.client});
  @override
  Future<List<PostModel>> getListPosts() async {
    final Uri uri = Uri.https(_baseUrl, _GET_POSTS);

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      print(response.body);
      List<PostModel> listPosts = postListModelFromJson(response.body);
      print(listPosts);
      return listPosts;
    } else {
      throw ServerExceptions();
    }
  }

  @override
  Future<PostModel> getPost(int postId) async {
    final Uri uri = Uri.https(_baseUrl, '$_GET_POSTS/$postId');

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      print(response.body);
      PostModel post = PostModel.fromJson(json.decode(response.body));
      print(post);
      return post;
    } else {
      throw ServerExceptions();
    }
  }
}

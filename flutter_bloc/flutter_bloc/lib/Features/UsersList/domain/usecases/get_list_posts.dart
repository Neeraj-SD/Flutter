import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc_demo/Features/UsersList/domain/entities/post.dart';
import 'package:flutter_bloc_demo/Features/UsersList/domain/repositories/posts_repository.dart';
import 'package:flutter_bloc_demo/core/errors/failures.dart';
import 'package:flutter_bloc_demo/core/usecases/usecase.dart';

class GetListPosts implements UseCase<List<Post>, NoParams> {
  final PostsRepository repository;

  GetListPosts(this.repository);

  @override
  Future<Either<Failure, List<Post>>> call(NoParams params) async {
    return await repository.getListPosts();
  }
}

class GetPost implements UseCase<Post, Params> {
  final PostsRepository repository;
  GetPost({
    required this.repository,
  });

  @override
  Future<Either<Failure, Post>> call(Params params) async {
    return await repository.getPost(params.postId);
  }
}

class Params extends Equatable {
  final int postId;
  const Params({
    required this.postId,
  });

  @override
  List<Object?> get props => [postId];
}

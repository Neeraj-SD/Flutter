import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/posts_repository.dart';
import '../datasources/posts_local_datasource.dart';
import '../datasources/posts_remote_datasource.dart';

class PostsRepositoryImpl implements PostsRepository {
  final PostsLocalDataSource localDataSource;
  final PostsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  PostsRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Post>>> getListPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final listPosts = await remoteDataSource.getListPosts();
        localDataSource.cacheListPosts(listPosts);
        return Right(listPosts);
      } on ServerExceptions {
        return Left(ServerFailure());
      }
    } else {
      try {
        final listPosts = await localDataSource.getListPosts();
        return Right(listPosts);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Post>> getPost(int postId) async {
    if (await networkInfo.isConnected) {
      try {
        final post = await remoteDataSource.getPost(postId);
        localDataSource.cachePost(post, postId);
        return Right(post);
      } on ServerExceptions {
        return Left(ServerFailure());
      }
    } else {
      try {
        final post = await localDataSource.getPost(postId);
        return Right(post);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}

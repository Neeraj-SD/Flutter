import '../models/post_model.dart';
import '../../../../core/errors/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostsLocalDataSource {
  /// Gets the cached [PostModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.

  Future<List<PostModel>> getListPosts();
  Future<void> cacheListPosts(List<PostModel> listPosts);

  Future<PostModel> getPost(int postId);
  Future<void> cachePost(PostModel post, int postId);
}

const String CACHED_LIST_POSTS = 'CACHED_LIST_POSTS';

class PostsLocalDataSourceImpl implements PostsLocalDataSource {
  final SharedPreferences sharedPreferences;

  PostsLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheListPosts(List<PostModel> listPosts) {
    return sharedPreferences.setString(
        CACHED_LIST_POSTS, postListModelToJson(listPosts));
  }

  @override
  Future<List<PostModel>> getListPosts() {
    final jsonString = sharedPreferences.getString(CACHED_LIST_POSTS);
    if (jsonString != null) {
      return Future.value(postListModelFromJson(jsonString));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cachePost(PostModel post, int postId) {
    return sharedPreferences.setString(
        '$CACHED_LIST_POSTS/$postId', postModelToJson(post));
  }

  @override
  Future<PostModel> getPost(int postId) {
    final jsonString =
        sharedPreferences.getString('$CACHED_LIST_POSTS/$postId');
    if (jsonString != null) {
      return Future.value(postModelFromJson(jsonString));
    } else {
      throw CacheException();
    }
  }
}

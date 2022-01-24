part of 'posts_list_cubit.dart';

abstract class PostsListState extends Equatable {
  @override
  List<Object> get props => [];

  // get post => null;
}

class Initial extends PostsListState {}

class Loading extends PostsListState {}

class Loaded extends PostsListState {
  final List<Post> posts;

  Loaded({
    required this.posts,
  });
  @override
  List<Object> get props => [posts];
}

class Selected extends PostsListState {
  final Post post;

  Selected({required this.post});
  @override
  List<Object> get props => [post];
}

class Error extends PostsListState {}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/post.dart';
import '../../domain/usecases/get_list_posts.dart';

part 'posts_list_state.dart';

class PostsListCubit extends Cubit<PostsListState> {
  final GetListPosts getListPosts;

  PostsListCubit({
    required this.getListPosts,
  }) : super(Initial());

  void getPosts() async {
    emit(Loading());
    final response = await getListPosts(NoParams());
    emit(response.fold((failure) => Error(), (posts) => Loaded(posts: posts)));
  }

  void setSelectedPostId(Post post) => emit(Selected(post: post));

  void setLoaded() => emit(Loaded());
}

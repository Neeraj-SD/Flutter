import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/Features/UsersList/presentation/cubit/posts_list_cubit.dart';

class PostsListScreen extends StatelessWidget {
  const PostsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<PostsListCubit>().getPosts();
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<PostsListCubit, PostsListState>(
        builder: (context, state) {
          if (state is Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is Loaded) {
            return ListView.separated(
              itemBuilder: (_, index) => GestureDetector(
                onTap: () async {
                  context
                      .read<PostsListCubit>()
                      .setSelectedPostId(state.posts[index]);
                  await Navigator.of(context).pushNamed('/postsExpanded');
                  context.read<PostsListCubit>().;
                },
                child: ListTile(
                  // dense: true,
                  style: ListTileStyle.list,
                  leading: Text('${state.posts[index].id}'),
                  title: Text(state.posts[index].title),
                  subtitle: Text(state.posts[index].body),
                ),
              ),
              separatorBuilder: (_, index) => const Divider(height: 20),
              itemCount: state.posts.length,
            );
          } else {
            return const Text('error');
          }
        },
      ),
    );
  }
}

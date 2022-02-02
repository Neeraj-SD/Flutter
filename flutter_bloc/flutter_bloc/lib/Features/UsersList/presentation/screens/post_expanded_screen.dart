import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/posts_list_cubit.dart';

class PostExpandedScreen extends StatelessWidget {
  const PostExpandedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<PostsListCubit, PostsListState>(
        builder: (context, state) {
          if (state is Selected) {
            return ListTile(
              // dense: true,
              style: ListTileStyle.list,
              leading: Text('${state.post.id}'),
              title: Text(state.post.title),
              subtitle: Text(state.post.body),
            );
          } else {
            return const Text('Error');
          }
        },
      ),
    );
  }
}

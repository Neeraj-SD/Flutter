import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/album_cubit.dart';

class AlbumsScreen extends StatelessWidget {
  const AlbumsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AlbumCubit>().getAlbums();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Albums Screen'),
      ),
      body: BlocBuilder<AlbumCubit, AlbumState>(
        builder: (context, state) {
          if (state is AlbumLoaded) {
            return ListView.separated(
                itemBuilder: (context, index) =>
                    Text(state.albums[index].title),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                itemCount: state.albums.length);
          } else if (state is AlbumLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Text('error');
          }
        },
      ),
    );
  }
}

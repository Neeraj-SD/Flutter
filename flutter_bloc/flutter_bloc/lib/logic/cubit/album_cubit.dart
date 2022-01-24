import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_demo/logic/models/user.dart';
import 'package:meta/meta.dart';

import 'package:flutter_bloc_demo/logic/models/album.dart';
import 'package:flutter_bloc_demo/repo/services.dart';

part 'album_state.dart';

class AlbumCubit extends Cubit<AlbumState> {
  final AlbumsRepo albumsRepo;
  late List<AlbumModel> albums;

  AlbumCubit({
    required this.albumsRepo,
  }) : super(AlbumInitial());

  void getAlbums() async {
    emit(AlbumLoading());
    albums = await albumsRepo.getAlbumsService();
    emit(AlbumLoaded(albums));
  }
}

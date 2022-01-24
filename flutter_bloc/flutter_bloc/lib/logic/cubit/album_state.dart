part of 'album_cubit.dart';

@immutable
abstract class AlbumState {}

class AlbumInitial extends AlbumState {}

class AlbumLoading extends AlbumState {}

class AlbumLoaded extends AlbumState {
  final List<AlbumModel> albums;

  AlbumLoaded(this.albums);
}

class AlbumError extends AlbumState {
  final error;

  AlbumError(this.error);
}

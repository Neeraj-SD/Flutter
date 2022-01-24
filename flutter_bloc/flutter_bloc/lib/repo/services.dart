import 'package:flutter_bloc_demo/logic/models/album.dart';
import 'package:flutter_bloc_demo/logic/models/user.dart';
import 'package:http/http.dart' as http;

abstract class AlbumsRepo {
  Future<List<AlbumModel>> getAlbumsService();
  Future<List<User>> getUserServices();
}

class AlbumsService implements AlbumsRepo {
  static const _baseUrl = 'jsonplaceholder.typicode.com';
  static const String _GET_ALBUMS = '/albums';
  static const String _GET_USERS = '/users';

  @override
  Future<List<AlbumModel>> getAlbumsService() async {
    final Uri uri = Uri.https(_baseUrl, _GET_ALBUMS);

    http.Response response = await http.get(uri);
    List<AlbumModel> listAlbums = albumModelFromJson(response.body);
    return listAlbums;
  }

  @override
  Future<List<User>> getUserServices() async {
    final Uri uri = Uri.https(_baseUrl, _GET_USERS);

    http.Response response = await http.get(uri);
    List<User> listUsers = userFromJson(response.body);
    return listUsers;
  }
}

import 'Features/Auth/data/repositories/user_repository_impl.dart';
import 'Features/Auth/domain/repositories/user_repository.dart';
import 'Features/Auth/domain/usecase/post_login.dart';
import 'Features/Auth/presentation/cubit/auth_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Features/UsersList/data/datasources/posts_local_datasource.dart';
import 'Features/UsersList/data/datasources/posts_remote_datasource.dart';
import 'Features/UsersList/data/repositories/posts_repository_impl.dart';
import 'Features/UsersList/domain/repositories/posts_repository.dart';
import 'Features/UsersList/domain/usecases/get_list_posts.dart';
import 'Features/UsersList/presentation/cubit/posts_list_cubit.dart';
import 'core/network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Posts
  // Bloc
  sl.registerFactory(
    () => PostsListCubit(
      getListPosts: sl(),
    ),
  );

  //UseCases
  sl.registerLazySingleton(() => GetListPosts(sl()));

  // Repository
  sl.registerLazySingleton<PostsRepository>(() => PostsRepositoryImpl(
        localDataSource: sl(),
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));

  // Data sources
  sl.registerLazySingleton<PostsRemoteDataSource>(
    () => PostsRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<PostsLocalDataSource>(
    () => PostsLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );
  //! Features - Auth
  // Bloc
  sl.registerFactory(
    () => AuthCubit(postLogin: sl()),
  );

  //UseCases
  sl.registerLazySingleton(() => PostLogin(sl()));

  // Repository
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(sl()));

  // Data sources
  // sl.registerLazySingleton<PostsRemoteDataSource>(
  //   () => PostsRemoteDataSourceImpl(
  //     client: sl(),
  //   ),
  // );

  // sl.registerLazySingleton<PostsLocalDataSource>(
  //   () => PostsLocalDataSourceImpl(
  //     sharedPreferences: sl(),
  //   ),
  // );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      connectionChecker: sl(),
    ),
  );

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerFactory(
    () => GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    ),
  );
}

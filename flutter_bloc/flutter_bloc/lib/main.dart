import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/Features/UsersList/presentation/cubit/posts_list_cubit.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'injection_container.dart' as di;
import 'logic/cubit/album_cubit.dart';
import 'logic/cubit/counter_cubit.dart';
import 'logic/cubit/internet_cubit.dart';
import 'logic/cubit/settings_cubit.dart';
import 'logic/presentations/router/app_router.dart';
import 'logic/presentations/screens/home_screen.dart';
import 'repo/services.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());

  HydratedBlocOverrides.runZoned(
      () async => runApp(MyApp(
            appRouter: AppRouter(),
            connectivity: Connectivity(),
          )),
      storage: storage);
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final Connectivity connectivity;

  const MyApp({Key? key, required this.appRouter, required this.connectivity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CounterCubit(),
        ),
        BlocProvider(
          create: (context) => InternetCubit(connectivity: connectivity),
        ),
        BlocProvider(
          create: (context) => SettingsCubit(),
        ),
        BlocProvider(
          create: (context) => AlbumCubit(albumsRepo: AlbumsService()),
        ),
        BlocProvider(
          create: (context) => di.sl<PostsListCubit>(),
        ),
      ],
      child: MaterialApp(
        onGenerateRoute: appRouter.onGenerateRoute,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

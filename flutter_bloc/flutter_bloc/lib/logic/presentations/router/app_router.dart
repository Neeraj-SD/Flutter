import 'package:flutter/material.dart';
import 'package:flutter_bloc_demo/Features/UsersList/presentation/screens/post_expanded_screen.dart';
import 'package:flutter_bloc_demo/Features/UsersList/presentation/screens/posts_list_screen.dart';

import '../screens/albums_screen.dart';
import '../screens/home_screen.dart';
import '../screens/second_screen.dart';
import '../screens/settings_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case '/second':
        return MaterialPageRoute(
            builder: (_) =>
                const SecondScreen(title: 'Second Screen', color: Colors.red));
      case '/settings':
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case '/albums':
        return MaterialPageRoute(builder: (_) => const AlbumsScreen());
      case '/posts':
        return MaterialPageRoute(builder: (_) => const PostsListScreen());
      case '/postsExpanded':
        return MaterialPageRoute(builder: (_) => const PostExpandedScreen());
      default:
        return null;
    }
  }
}

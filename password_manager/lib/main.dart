import 'package:flutter/material.dart';
import 'package:password_manager/models/password.dart';
import 'package:password_manager/screens/passwordExpanded.dart';
import 'package:password_manager/screens/password_overview.dart';

//@dart=2.9
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: PasswordOverview(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => PasswordOverview(),
        PasswordExpanded.routeName: (ctx) => PasswordExpanded(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

import 'package:flutter/material.dart';
import 'package:password_manager/models/password.dart';
import 'package:password_manager/screens/passwordExpanded.dart';

class PasswordOverview extends StatelessWidget {
  const PasswordOverview({Key key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Password'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
      ),
      body: Column(
        children: [
          Container(),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (_, ind) => GestureDetector(
              onTap: () =>
                  Navigator.of(context).pushNamed(PasswordExpanded.routeName),
              child: ListTile(
                leading: Icon(Icons.home),
                title: Text('Url'),
                subtitle: Text('username'),
                trailing: IconButton(
                  icon: Icon(Icons.copy),
                  onPressed: () {},
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

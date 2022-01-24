import 'package:flutter/material.dart';
import 'package:mvvm_demo/users_list/view_model/users_view_model.dart';
import 'package:provider/provider.dart';

class AddUserScreen extends StatelessWidget {
  const AddUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UsersViewModel usersViewModel = context.watch();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Users'),
        actions: [
          IconButton(
            onPressed: () async {
              if (usersViewModel.addUser()) {
                Navigator.of(context).pop();
              }
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: const InputDecoration(
                label: Text('Name'),
              ),
              onChanged: (value) async {
                usersViewModel.addedUser.name = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: const InputDecoration(
                label: Text('Email'),
              ),
              onChanged: (value) async {
                usersViewModel.addedUser.email = value;
              },
            ),
          )
          //  TextField(),
        ],
      ),
    );
  }
}

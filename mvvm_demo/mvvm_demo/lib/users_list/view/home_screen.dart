import 'package:flutter/material.dart';
import 'package:mvvm_demo/users_list/models/users_list_model.dart';
import 'package:mvvm_demo/users_list/view_model/users_view_model.dart';
import 'package:mvvm_demo/utils/navigation_routes.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    UsersViewModel usersViewModel = context.watch<UsersViewModel>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Users List'),
        actions: [
          IconButton(
            onPressed: () async => openAddUserScreen(context),
            icon: const Icon(
              Icons.add,
              size: 30,
            ),
          )
        ],
      ),
      body: _ui(usersViewModel),
    );
  }

  _ui(UsersViewModel usersViewModel) {
    if (usersViewModel.loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (usersViewModel.userError != null) {
      return Container();
    }
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: usersViewModel.userListModel.length,
              itemBuilder: (context, ind) {
                UserModel userModel = usersViewModel.userListModel[ind];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: InkWell(
                    onTap: () async {
                      usersViewModel.setSelectedUserModel(userModel);
                      openUserDetailsScreen(context);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userModel.name as String,
                          // ignore: prefer_const_constructors
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(userModel.email as String),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}

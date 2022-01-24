import 'package:flutter/material.dart';
import 'package:mvvm_demo/users_list/models/add_user_screen.dart';
import 'package:mvvm_demo/users_list/view/user_details_screen.dart';

void openUserDetailsScreen(BuildContext context) async {
  await Navigator.of(context)
      .push(MaterialPageRoute(builder: (_) => const UserDetailsScreen()));
}

void openAddUserScreen(BuildContext context) async {
  await Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => const AddUserScreen(),
    ),
  );
}

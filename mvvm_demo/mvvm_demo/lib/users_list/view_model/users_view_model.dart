import 'package:flutter/material.dart';
import 'package:mvvm_demo/users_list/models/user_error.dart';
import 'package:mvvm_demo/users_list/models/users_list_model.dart';
import 'package:mvvm_demo/users_list/repo/api_status.dart';
import 'package:mvvm_demo/users_list/repo/user_services.dart';

class UsersViewModel extends ChangeNotifier {
  bool _loading = false;
  List<UserModel> _userListModel = [];
  UserError? _userError;
  late UserModel _selectedUserModel;
  late UserModel _addedUser;

  bool get loading => _loading;
  List<UserModel> get userListModel => _userListModel;
  UserError? get userError => _userError;
  UserModel get selectedUserModel => _selectedUserModel;
  UserModel get addedUser => _addedUser;

  UsersViewModel() {
    getUsers();
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setUserListModel(List<UserModel> userListModel) {
    _userListModel = userListModel;
  }

  setUserError(UserError userError) {
    _userError = userError;
  }

  setSelectedUserModel(UserModel userModel) {
    _selectedUserModel = userModel;
  }

  setAddedUser(UserModel userModel) {
    _addedUser = userModel;
  }

  bool isValidUser(UserModel userModel) {
    if (userModel.name == null || userModel.email == null) return false;

    return true;
  }

  addUser() async {
    if (!isValidUser(_addedUser)) {
      return false;
    }
    _userListModel.add(_addedUser);
    _addedUser = UserModel();
    notifyListeners();
    return true;
  }

  getUsers() async {
    setLoading(true);
    var response = await UserServices.getUsers();
    if (response is Success) {
      setUserListModel(response.response as List<UserModel>);
    }
    if (response is Failure) {
      UserError userError =
          UserError(code: response.code, message: response.errorResponse);
    }
    setLoading(false);
  }
}

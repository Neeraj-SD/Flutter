import 'dart:io';

import 'package:mvvm_demo/users_list/models/users_list_model.dart';
import 'package:mvvm_demo/users_list/repo/api_status.dart';
import 'package:mvvm_demo/utils/constant.dart';
import 'package:http/http.dart' as http;

class UserServices {
  static Future<Object> getUsers() async {
    try {
      final url = Uri.parse(USERS_LIST);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return Success(response: UserModelFromJson(response.body), code: 200);
      }
      return Failure(
          code: USER_INVALID_RESPONSE, errorResponse: 'Invalid Response');
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: 'No Internet');
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Format');
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Unknown Error');
      //
    }
  }
}

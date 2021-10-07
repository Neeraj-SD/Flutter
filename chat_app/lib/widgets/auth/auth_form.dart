import 'dart:io';

import 'package:chat_app/pickers/user_img_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final bool isLoading;
  final Function(
    String email,
    String password,
    String username,
    File image,
    BuildContext ctx,
    bool isLogin,
  ) submitfn;

  AuthForm(this.submitfn, this.isLoading);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;

  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';
  File _pickedImg;

  void pickImage(File img) {
    _pickedImg = img;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();

    FocusScope.of(context).unfocus();

    if (_pickedImg == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          elevation: 4,
          backgroundColor: Theme.of(context).errorColor,
          content: Text('Choose your DP'),
        ),
      );
      return;
    }

    if (isValid) {
      _formKey.currentState.save();
    }

    widget.submitfn(
      _userEmail.trim(),
      _userName.trim(),
      _userPassword.trim(),
      _pickedImg,
      context,
      _isLogin,
    );
    // print(_userEmail);
    // print(_userName);
    // print(_userPassword);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_isLogin) UserImagePicker(pickImage),
                  TextFormField(
                    key: ValueKey('Email'),
                    validator: (value) {
                      if (value != null &&
                          (value.isEmpty || !value.contains('@')))
                        return 'Please enter a valid email!';
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'Email Adress'),
                    onSaved: (value) {
                      _userEmail = value;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      validator: (value) {
                        if (value != null &&
                            (value.isEmpty || value.length < 4))
                          return 'Username must be atleast 4 characters';
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Username'),
                      onSaved: (value) {
                        _userName = value;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value != null && (value.isEmpty || value.length < 6))
                        return 'Password must be atleast 6 characters';
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onSaved: (value) {
                      _userPassword = value;
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    RaisedButton(
                      onPressed: _trySubmit,
                      child: Text(_isLogin ? 'Login' : 'Sign up'),
                    ),
                  if (!widget.isLoading)
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(_isLogin
                          ? 'Create new Account'
                          : 'Already have an account?'),
                      textColor: Theme.of(context).primaryColor,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

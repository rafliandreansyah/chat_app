import 'dart:io';

import 'package:flutter/material.dart';

import '../pick_image/user_pick_image.dart';

class AuthForm extends StatefulWidget {
  var _isLoading;
  final void Function(String email, String password, String username,
      bool isLogin, File imgFile) _submitAuth;

  AuthForm(this._submitAuth, this._isLoading);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = '';
  String _userName = '';
  String _password = '';
  bool _isLogin = true;
  File? _imgFile;

  void _pickImage(File imgFile) {
    _imgFile = imgFile;
  }

  void _submit() {
    var isValid = _formKey.currentState!.validate();
    FocusManager.instance.primaryFocus?.unfocus();
    if (_imgFile == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Please pick an image',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
      return;
    }

    if (isValid) {
      _formKey.currentState!.save();
      // print(_email);
      // print(_userName);
      // print(_password);

      widget._submitAuth(_email, _password, _userName, _isLogin, _imgFile!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_isLogin) UserPickImage(_pickImage),
                  TextFormField(
                      key: const ValueKey('email'),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Please, enter valid email';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email Address',
                      ),
                      onSaved: (value) {
                        _email = value!;
                      }),
                  if (!_isLogin)
                    TextFormField(
                      key: const ValueKey('username'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Username cannot be empty!';
                        }
                        if (value.length < 4) {
                          return 'Username length minimum 4 characters';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Username',
                      ),
                      onSaved: (value) {
                        _userName = value!;
                      },
                    ),
                  TextFormField(
                      key: ValueKey('password'),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password cannot be empty!';
                        }
                        if (!_isLogin) {
                          if (value.length < 6) {
                            return 'Minimum length password 6 character';
                          }
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                      onSaved: (value) {
                        _password = value!;
                      }),
                  const SizedBox(
                    height: 12,
                  ),
                  if (widget._isLoading) const CircularProgressIndicator(),
                  if (!widget._isLoading)
                    ElevatedButton(
                      onPressed: _submit,
                      child: Text(_isLogin ? 'Login' : 'Sign up'),
                    ),
                  if (!widget._isLoading)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(_isLogin
                          ? 'Create new account'
                          : 'Already have account'),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

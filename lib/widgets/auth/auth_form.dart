import 'package:chat_app_v2/widgets/pickers/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  //const AuthForm({Key key}) : super(key: key);
  final bool isLoading;
  final void Function(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  AuthForm(this.submitFn, this.isLoading);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState
        .validate(); // triggers all validators and returns a boolean
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save(); // triggers the onSaved prop
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
      margin: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              if(!_isLogin) UserImagePicker(),
              TextFormField(
                key: ValueKey('email'),
                validator: (value) {
                  if (value.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email adress';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email adress',
                ),
                onSaved: (newValue) {
                  _userEmail = newValue;
                },
              ),
              if (!_isLogin)
                TextFormField(
                  key: ValueKey('username'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a valid username';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Username'),
                  onSaved: (newValue) {
                    _userName = newValue;
                  },
                ),
              TextFormField(
                key: ValueKey('password'),
                validator: (value) {
                  if (value.isEmpty || value.length < 7) {
                    return 'Password must be at least 7 characters long.';
                  }
                  return null;
                },
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
                onSaved: (newValue) {
                  _userPassword = newValue;
                },
              ),
              SizedBox(
                height: 12,
              ),
              widget.isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _trySubmit,
                      child: Text(_isLogin ? 'Login' : 'Signup')),
              TextButton(
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                    });
                  },
                  child: Text(_isLogin
                      ? 'Create new account'
                      : 'I already have an account')),
            ]),
          ),
        ),
      ),
    ));
  }
}

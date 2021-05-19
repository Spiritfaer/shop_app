import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screen/auth_screen.dart';
import '../screen/products_overview_screen.dart';
import '../models/http_exception.dart';
import '../providers/auth.dart';

class AuthCard extends StatefulWidget {
  AuthCard({Key key}) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {'email': '', 'password': ''};

  bool _isLoading = false;
  final _passwordController = TextEditingController();

  void _switchAuthMode() {
    setState(() {
      _authMode =
          (_authMode == AuthMode.Login) ? AuthMode.Signup : AuthMode.Login;
    });
  }

  void _showErrorMessage(String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        duration: Duration(seconds: 4),
      ),
    );
  }

  void _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        await Provider.of<Auth>(context, listen: false).login(
          _authData['email'],
          _authData['password'],
        );
      } else {
        await Provider.of<Auth>(context, listen: false).signup(
          _authData['email'],
          _authData['password'],
        );
      }
      Navigator.pushReplacementNamed(context, ProtuctsOverviewScreen.nameRoute);
    } on HttpException catch (error) {
      _showErrorMessage(error.userMessage);
    } catch (error) {
      _showErrorMessage('please try to connect later');
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8,
      child: Container(
        height: _authMode == AuthMode.Signup ? 320 : 260,
        width: deviceSize.width * 0.90,
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _authData['email'] = newValue;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value.isEmpty || value.length < 5) {
                      return 'Passwort to short';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _authData['password'] = newValue;
                  },
                ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(labelText: 'Confirm Password'),
                    obscureText: true,
                    validator: _authMode == AuthMode.Signup
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match!';
                            }
                            // return null;
                          }
                        : null,
                  ),
                SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  ElevatedButton(
                    child:
                        Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SING UP'),
                    onPressed: _submit,
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 8.0),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor,
                      ),
                      textStyle: MaterialStateProperty.all(
                        TextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .button
                                .color),
                      ),
                    ),
                  ),
                TextButton(
                  child: Text(
                      '${_authMode == AuthMode.Login ? 'SINGUP' : 'LOGIN'} INSTEAD'),
                  onPressed: _switchAuthMode,
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 4.0),
                    ),
                    textStyle: MaterialStateProperty.all(
                      TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app1/models/http_exception.dart';

class Auth with ChangeNotifier {
  final String _API_KEY = 'AIzaSyAWm-WI9BM_kiKj75pMAgITG_s7tvD2FsU';
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  bool get isAuth => token != null;
  String get user => _userId;
  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> _authentificate(
      String email, String password, String requiest) async {
    final url = Uri.https(
      'identitytoolkit.googleapis.com',
      requiest,
      {
        'key': _API_KEY,
      },
    );
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      var responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData['expiresIn']),
        ),
      );
      _autoLogout();
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    final requistSingUp = '/v1/accounts:signUp';
    return _authentificate(email, password, requistSingUp);
  }

  Future<void> login(String email, String password) async {
    final requistSignInWithPassword = '/v1/accounts:signInWithPassword';
    return _authentificate(email, password, requistSignInWithPassword);
  }

  void logout() {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}

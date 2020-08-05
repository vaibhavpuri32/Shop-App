import 'package:cart/models/http_exception.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Auth extends ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;


  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get userId
  {
    return _userId;
  }

  void logout()
  {
    _token = null;
    _expiryDate = null;
    _userId = null;
    notifyListeners();
  }

  Future<void> _authenticate(
      String email, String password, String urlsegment) async {
    try {
      final url =
          "https://identitytoolkit.googleapis.com/v1/accounts:$urlsegment?key=AIzaSyBPZyd7um7TokTLMQYTWVudCXmz-dUmaIA";
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));

      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));

      notifyListeners();
    } catch (error) {
      throw error;
    }

    //print(json.decode(response.body));
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, "signUp");
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, "signInWithPassword");
  }
}

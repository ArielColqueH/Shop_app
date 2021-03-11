import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
//      'https://www.googleapis.com/identitytoolkit/v3/relyingparty/$urlSegment?key=xxx';
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyAkEgO_gNrZSccBAXszmW2fR6MfcNSSzC4';
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
      print(json.decode(response.body));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
//  return _authenticate(email, password, 'signupNewUser');
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
//  return _authenticate(email, password, 'verifyPassword');
    return _authenticate(email, password, 'signInWithPassword');
  }
}

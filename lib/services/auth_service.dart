import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService extends ChangeNotifier {

  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyCwQYMMlROaHlO12wGuTuIwBxTezL2iBdU';

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };
    final url = Uri.https(_baseUrl, '/v1/accounts:signInWithPassword', {'key': _firebaseToken});
    print(authData);
    final response = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodeResponse = json.decode(response.body);
    if (decodeResponse.containsKey('idToken')) {
      return null;
    } else {
      return decodeResponse['error']['message'];
    }
  }

  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };
    final url = Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _firebaseToken});
    print(authData);
    final response = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodeResponse = json.decode(response.body);
    if (decodeResponse.containsKey('idToken')) {
      return null;
    } else {
      return decodeResponse['error']['message'];
    }
  }  
}
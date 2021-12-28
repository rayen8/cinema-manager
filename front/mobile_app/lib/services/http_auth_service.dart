import 'dart:convert';

import 'package:cinema_app/models/user.dart';
import 'package:cinema_app/utils/constants.dart';
import 'package:http/http.dart';

class HttpAuthService {
  final String endpoint = GlobalData.authUrl;

  Future<User> registerWithEmailAndPassword(
      String email, String password) async {
    final response = await post(
      Uri.parse("$endpoint/register"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        {'email': email, 'password': password},
      ),
    );

    if (response.statusCode == 200) {
      return User.fromMap(
        jsonDecode(response.body),
      );
    } else {
      throw Exception('Failed to register.');
    }
  }

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final response = await post(
      Uri.parse("$endpoint/login"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        {'email': email, 'password': password},
      ),
    );

    if (response.statusCode == 200) {
      return User.fromMap(
        jsonDecode(response.body),
      );
    } else {
      throw Exception('Failed to register.');
    }
  }
}

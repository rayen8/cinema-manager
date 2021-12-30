import 'dart:convert';

import 'package:cinema_app/services/auth/auth_service.dart';
import 'package:cinema_app/utils/constants.dart';
import 'package:http/http.dart';

/// Handles `HTTP` calls to login & register a user.
///
/// **Warning:** Do not instantiate this class, simply use [AuthService].
class HttpAuth {
  static final HttpAuth _httpAuthService = HttpAuth._internal();
  factory HttpAuth() {
    return _httpAuthService;
  }
  HttpAuth._internal();

  final String endpoint = GlobalData.authUrl;

  Future<String> registerWithEmailAndPassword(
      String email, String password) async {
    final response = await post(
      Uri.parse("$endpoint/register"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        {'username': email, 'password': password},
      ),
    );

    if (response.statusCode == 200) {
      return response.headers["authorization"].toString();
    } else {
      throw Exception('Failed to register.');
    }
  }

  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    final response = await post(
      Uri.parse("$endpoint/login"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        {'username': email, 'password': password},
      ),
    );

    if (response.statusCode == 200) {
      return response.headers["authorization"].toString();
    } else {
      throw Exception('Failed to sign in.');
    }
  }
}

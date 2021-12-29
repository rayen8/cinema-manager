import 'dart:convert';

import 'package:cinema_app/models/user.dart';
import 'package:cinema_app/services/auth/strategy_service.dart';
import 'package:cinema_app/utils/constants.dart';
import 'package:http/http.dart';

/// Registers & Signs in a user by internally calling [AuthStrategyService].
///
/// **Note:** You still have to update the state yourself (using a stream for example).
class HttpAuthService {
  final AuthStrategyService _authStrategyService = AuthStrategyService();
  final String endpoint = GlobalData.authUrl;

  Future<User> registerWithEmailAndPassword(
      String email, String password) async {
    final response = await post(
      Uri.parse("$endpoint/register"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        {'username': email, 'password': password},
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
        {'username': email, 'password': password},
      ),
    );

    if (response.statusCode == 200) {
      return _authStrategyService.doLoginAndGetUser(
        response.headers["authorization"].toString(),
      );
    } else {
      throw Exception('Failed to sign in.');
    }
  }
}

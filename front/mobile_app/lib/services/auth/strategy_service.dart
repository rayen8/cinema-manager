import 'package:cinema_app/models/user.dart';
import 'package:cinema_app/services/auth/http_service.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';

/// The auth strategy used in the application.
/// This is currently an implementation of `Json Web Token`.
///
/// Returns a `Singleton` that handles reading, deleting & setting the token
/// as well as decoding it & returning a [User] from it.
///
/// **Warning:** Do not implement this class, simply use [HttpAuthService].
class AuthStrategyService {
  static final AuthStrategyService _authStrategyService =
      AuthStrategyService._internal();
  factory AuthStrategyService() {
    return _authStrategyService;
  }

  AuthStrategyService._internal();

  /// The key name the token is identified by.
  final String keyName = "JWT_TOKEN";

  Future<void> storeToken(String token) async {
    await const FlutterSecureStorage().write(
      key: keyName,
      value: token,
    );
  }

  Future<String?> getToken() async {
    return await const FlutterSecureStorage().read(key: keyName);
  }

  Future deleteToken() async {
    await const FlutterSecureStorage().delete(key: keyName);
  }

  Future<User> doLoginAndGetUser(String token) async {
    // log("Token is: " + token);
    await storeToken(token);
    return User.fromMap(Jwt.parseJwt(token));
  }
}

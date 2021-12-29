import 'package:cinema_app/models/user.dart';
import 'package:cinema_app/services/auth/auth_service.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';

/// The auth strategy used in the application.
/// This is currently an implementation of `Json Web Token`.
///
/// Returns a `Singleton` that handles reading, deleting & setting the token
/// as well as decoding it & returning a [User] from it.
///
/// **Warning:** Do not instantiate this class, simply use [AuthService].
class AuthStrategy {
  static final AuthStrategy _authStrategy = AuthStrategy._internal();
  factory AuthStrategy() {
    return _authStrategy;
  }
  AuthStrategy._internal();

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

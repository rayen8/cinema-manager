import 'dart:developer';

import 'package:cinema_app/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthStrategyService {
  static String keyName = "JWT_TOKEN";

  static Future<void> storeToken(String token) async {
    await const FlutterSecureStorage().write(
      key: keyName,
      value: token,
    );
  }

  static Future<String?> getToken() async {
    return await const FlutterSecureStorage().read(key: keyName);
  }

  static Future deleteToken() async {
    await const FlutterSecureStorage().delete(key: keyName);
  }

  static Future<User> doLoginAndGetUser(String token) async {
    log("Token is: " + token);
    await storeToken(token);
    // TODO: Get user & roles from token
    return User(0, "test");
  }
}

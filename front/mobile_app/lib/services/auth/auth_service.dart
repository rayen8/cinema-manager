import 'package:cinema_app/models/user.dart';
import 'package:cinema_app/services/auth/http_auth.dart';
import 'package:cinema_app/services/auth/auth_strategy.dart';

/// Main class used to handle all auth functionality.
///
/// Handles the authentication events of the [User] such as logging in & out.
///
/// **Note:** The state of the app still has to be manually updated (using a stream for example).
class AuthService {
  final HttpAuth _httpAuth = HttpAuth();
  final AuthStrategy _authStrategyService = AuthStrategy();

  Future<User> register(String username, String password) async {
    String token = await _httpAuth.registerWithEmailAndPassword(
      username,
      password,
    );
    return _authStrategyService.doLoginAndGetUser(token);
  }

  Future<User> login(String username, String password) async {
    String token = await _httpAuth.signInWithEmailAndPassword(
      username,
      password,
    );
    return _authStrategyService.doLoginAndGetUser(token);
  }

  Future<void> logout() async {
    // Connection is stateless, no need to call another service
    await _authStrategyService.deleteToken();
  }
}

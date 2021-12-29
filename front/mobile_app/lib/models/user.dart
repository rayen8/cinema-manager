// import 'package:cinema_app/models/role.dart';

import 'package:cinema_app/models/role.dart';

class User {
  String username;
  List<Role> roles;

  User(this.username, this.roles);

  factory User.fromMap(
    Map<String, dynamic> map,
  ) {
    return User(
      map["sub"],
      (map["roles"] as List)
          .map(
            (rawRole) => Role.fromJson(rawRole),
          )
          .toList(),
    );
  }

  @override
  String toString() {
    return "User{username: $username, roles: $roles}";
  }
}

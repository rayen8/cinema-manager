class Role {
  String name;

  Role(this.name);

  factory Role.fromJson(dynamic rawRole) => Role(rawRole);

  @override
  String toString() {
    return name;
  }
}

class LoginResult {
  bool status;
  int id;
  LoginData data;
  String message;

  LoginResult({
    this.status,
    this.id,
    this.data,
    this.message,
  });

  LoginResult copyWith({
    bool status,
    int id,
    LoginData data,
    String message,
  }) =>
      LoginResult(
        status: status ?? this.status,
        id: id ?? this.id,
        data: data ?? this.data,
        message: message ?? this.message,
      );
}

class LoginData {
  User user;
  String token;

  LoginData({
    this.user,
    this.token,
  });

  LoginData copyWith({
    User user,
    String token,
  }) =>
      LoginData(
        user: user ?? this.user,
        token: token ?? this.token,
      );
}

class User {
  int id;
  String name;
  String email;
  DateTime emailVerifiedAt;
  dynamic gender;
  dynamic image;
  int roleId;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.gender,
    this.image,
    this.roleId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  User copyWith({
    int id,
    String name,
    String email,
    DateTime emailVerifiedAt,
    dynamic gender,
    dynamic image,
    int roleId,
    DateTime createdAt,
    DateTime updatedAt,
    dynamic deletedAt,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        gender: gender ?? this.gender,
        image: image ?? this.image,
        roleId: roleId ?? this.roleId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
      );
}

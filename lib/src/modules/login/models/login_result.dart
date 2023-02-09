class LoginResult {
  LoginResult({
    this.status,
    this.id,
    this.data,
    this.token,
    this.message,
  });

  bool status;
  int id;
  LoginData data;
  String token;
  String message;

  LoginResult copyWith({
    bool status,
    int id,
    LoginData data,
    String token,
    String message,
  }) =>
      LoginResult(
        status: status ?? this.status,
        id: id ?? this.id,
        data: data ?? this.data,
        token: token ?? this.token,
        message: message ?? this.message,
      );
}

class LoginData {
  LoginData({
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
    this.userRole,
    this.role,
  });

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
  String userRole;
  Role role;

  LoginData copyWith({
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
    String userRole,
    Role role,
  }) =>
      LoginData(
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
        userRole: userRole ?? this.userRole,
        role: role ?? this.role,
      );
}

class Role {
  Role({
    this.id,
    this.name,
    this.value,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  int value;
  DateTime createdAt;
  DateTime updatedAt;

  Role copyWith({
    int id,
    String name,
    int value,
    DateTime createdAt,
    DateTime updatedAt,
  }) =>
      Role(
        id: id ?? this.id,
        name: name ?? this.name,
        value: value ?? this.value,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
}

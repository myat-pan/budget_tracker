import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object> get props => [];
}

class Login extends AuthEvent {
  final String email;
  final String password;

  const Login(this.email, this.password);

  @override
  String toString() {
    return 'Login{email, password}';
  }

  @override
  List<Object> get props => [email, password];
}

// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:budget_tracker/src/modules/login/models/login.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}

class LoginSuccess extends AuthState {
  final bool status;
  final int id;
  final LoginData data;

  const LoginSuccess(this.status, this.id, this.data);

  @override
  List<Object> get props => [status, id, data];

  @override
  String toString() {
    return "AuthenticationAuthenticated";
  }
}

class FetchLoading extends AuthState {
  @override
  String toString() {
    return "FetchLoading";
  }
}

class LoginLoading extends AuthState {
  @override
  String toString() {
    return "AuthenticationLoading";
  }
}

class LoginFailure extends AuthState {
  final String error;

  LoginFailure({this.error});
  @override
  String toString() {
    return "FailAuthentication";
  }
}

class Unautheticated extends AuthState {
  @override
  String toString() => 'Unauthenticated';

  @override
  List<Object> get props => [];
}

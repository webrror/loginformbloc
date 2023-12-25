part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthSuccess extends AuthState {
  final String uid;
  final String name;
  final String? message;
  final int? code;

  AuthSuccess({
    required this.uid,
    required this.name,
    this.message,
    this.code,
  });
}

final class AuthFailure extends AuthState {
  final String error;
  final int? code;

  AuthFailure(this.error, {this.code});
}

final class AuthLoader extends AuthState{
  
}
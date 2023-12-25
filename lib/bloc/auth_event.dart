part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class SubmitEvent extends AuthEvent {
  final String email;
  final String password;

  SubmitEvent({
    required this.email,
    required this.password,
  });
}

final class LogoutEvent extends AuthEvent{
  
}

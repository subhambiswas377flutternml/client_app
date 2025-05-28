part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {
  const AuthEvent();
}

final class Authenticate extends AuthEvent{
  const Authenticate({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;
}

final class CheckAuth extends AuthEvent{
  const CheckAuth();
}

final class UnAuthenticate extends AuthEvent{
  const UnAuthenticate();
}
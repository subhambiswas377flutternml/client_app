part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class AuthLoading extends AuthState {
  const AuthLoading();
}

final class Authenticated extends AuthState{
  const Authenticated();
}

final class UnAuthenticated extends AuthState{
  const UnAuthenticated();
}

final class AuthError extends AuthState{
  const AuthError();
}
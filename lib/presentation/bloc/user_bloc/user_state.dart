part of 'user_bloc.dart';

@immutable
sealed class UserState {
  const UserState();
}

final class UserInitial extends UserState {
  const UserInitial();
}

final class UserLoading extends UserState{
  const UserLoading();
}

final class UserLoaded extends UserState{
  const UserLoaded({required this.data});

  final List<UserCacheModel> data;
}

final class UserError extends UserState{
  const UserError({this.ex});

  final Exception? ex;
}

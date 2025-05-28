part of 'user_bloc.dart';

@immutable
sealed class UserEvent {
  const UserEvent();
}

final class GetUser extends UserEvent{
  const GetUser();
}

final class AddUser extends UserEvent{
  const AddUser({
    this.name,
    this.emailId,
    this.phoneNumber,
    this.address,
    this.imagePath,
    this.lang,
    this.lat,
  });

  final String? imagePath;
  final String? name;
  final String? phoneNumber;
  final String? emailId;
  final String? address;
  final double? lat;
  final double? lang;
}

final class DeleteUser extends UserEvent{
  const DeleteUser({
    required this.index
  });

  final int index;
}

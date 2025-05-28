import 'package:bloc/bloc.dart';
import 'package:customer_app/data/model/user_cache_model.dart';
import 'package:customer_app/data/repository/user_repository.dart';
import 'package:flutter/foundation.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository = UserRepository();
  UserBloc() : super(UserInitial()) {
    // Get User Event
    on<GetUser>((event, emit) async {
      emit(UserLoading());

      final data = await _userRepository.getAllData();
      if(data!=null){
        emit(UserLoaded(data: data));
      }else{
        emit(UserError());
      }
    });

    // Add User Event
    on<AddUser>((event, emit) async {
      emit(UserLoading());

      final userData = UserCacheModel(
        name: event.name,
        phoneNumber: event.phoneNumber,
        emailId: event.emailId,
        address: event.address,
        photoPath: event.imagePath,
        lat: event.lat,
        lang: event.lang,
      );

      final data = await _userRepository.storeUserData(data: userData);
      if(data!=null){
        emit(UserLoaded(data: data));
      }else{
        emit(UserError());
      }
    });

    on<DeleteUser>((event, emit) async {
      emit(UserLoading());

      final data = await _userRepository.deleteUser(event.index);
      if(data!=null){
        emit(UserLoaded(data: data));
      }else{
        emit(UserError());
      }
    });
  }
}

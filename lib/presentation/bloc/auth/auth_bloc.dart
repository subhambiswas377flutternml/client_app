import 'package:bloc/bloc.dart';
import 'package:customer_app/data/repository/auth_repository.dart';
import 'package:flutter/material.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository = AuthRepository();
  AuthBloc() : super(AuthInitial()) {
    on<Authenticate>((event, emit) async{
      emit(AuthLoading());

      final data = await _authRepository.authenticate(username: event.username, password: event.password);
      if(data==null||data==false){
        emit(AuthError());
      }else{
        emit(Authenticated());
      }
    });

    on<UnAuthenticate>((event, emit) async{
      emit(AuthLoading());

      final data = await _authRepository.unAuthenticate();
      if(data==null||data==false){
        emit(AuthError());
      }else{
        emit(UnAuthenticated());
      }
    });

    on<CheckAuth>((event, emit) async{
      emit(AuthLoading());

      final data = await _authRepository.isAuthenticated();
      if(data==null||data==false){
        emit(UnAuthenticated());
      }else{
        emit(Authenticated());
      }
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:path2job/features/auth/data/models/auth_model.dart';

import '../../domain/usecases/signin_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignUpUseCase signUpUseCase;
  final SignInUseCase signInUseCase;

  AuthCubit(this.signUpUseCase, this.signInUseCase) : super(AuthInitial());

  Future<void> signUp(AuthModel model) async {
    emit(AuthLoading());
    try {
      await signUpUseCase(AuthModel(
          email: model.email,
          password: model.password,
          name: model.name,
          phone: model.phone,
          job: model.job));
      emit(AuthSuccess());
    } catch (e) {
      debugPrint(e.toString());
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());
    try {
      await signInUseCase(AuthModel(email: email, password: password));
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}

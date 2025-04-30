import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_lang_app/core/errors/failure.dart';
import 'package:sign_lang_app/core/widgets/custom_button_animation.dart';
import 'package:sign_lang_app/features/auth/data/models/reset_password_model.dart';
import 'package:sign_lang_app/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:sign_lang_app/features/auth/presentation/manager/reset_password_cubit/reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitialState());
  //final GlobalKey<CustomButtonState> btnKey = GlobalKey();

  void resetPassword(ResetPasswordReq resetPasswordReq,
      ResetPasswordUsecase resetPasswordUsecase) async {
    emit(ResetPasswordLoadingState());
    //btnKey.currentState!.animateForward();

    try {
      final Either<Failure, ResetPasswordResponse> result =
          await resetPasswordUsecase.call(resetPasswordReq);
      result.fold((failure) {
        emit(ResetPasswordFailureState(message: failure.message));
        //btnKey.currentState!.animateReverse();
      }, (data) {
        emit(ResetPasswordSuccessState(message: data.message, user: data.user));
        //btnKey.currentState!.animateReverse();
      });
    } catch (e) {
      log('error in ResetPasswordCubit');
      emit(ResetPasswordFailureState(message: e.toString()));
    }
  }
}
